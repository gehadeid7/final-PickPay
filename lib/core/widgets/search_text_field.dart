import 'package:flutter/material.dart';
import 'package:pickpay/core/utils/app_images.dart';
import 'package:pickpay/core/utils/app_text_styles.dart';
import 'package:pickpay/core/services/ai_search_service.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/services/api_service.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math';
import 'package:flutter/gestures.dart';
import 'dart:async';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:permission_handler/permission_handler.dart';

class SearchTextField extends StatefulWidget {
  final TextEditingController controller;
  final void Function(String) onSearch;
  final void Function(Map<String, dynamic>)? onProductSelected;

  const SearchTextField({
    super.key,
    required this.controller,
    required this.onSearch,
    this.onProductSelected,
  });

  @override
  State<SearchTextField> createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends State<SearchTextField> with SingleTickerProviderStateMixin {
  late final AISearchService _aiService;
  List<Map<String, dynamic>> _searchResults = [];
  List<String> _suggestions = [];
  bool _isLoading = false;
  bool _isFocused = false;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;
  late Animation<Offset> _slideAnimation;
  int _highlightedIndex = -1;
  FocusNode _focusNode = FocusNode();
  FocusNode _keyboardFocusNode = FocusNode();
  List<String> _recentSearches = [];
  static const String _recentSearchesKey = 'recent_searches';
  static const int _maxRecent = 10;
  List<String> _categories = [
    'Electronics', 'Fashion', 'Home', 'Beauty', 'Toys', 'Books', 'Grocery', 'Sports', 'Automotive', 'Health'
  ];
  List<String> _popularSearches = [
    'iPhone', 'Laptop', 'Headphones', 'Air Fryer', 'Smart Watch', 'Sneakers', 'Backpack', 'Bluetooth Speaker', 'Camera', 'Coffee Maker'
  ];
  String? _selectedCategory;
  String? _selectedPopular;
  List<String> _filters = [];
  bool _showDropdown = false;
  Timer? _debounce;
  final Map<String, List<Map<String, dynamic>>> _searchCache = {};
  bool _isProductLoading = false;
  stt.SpeechToText? _speech;
  bool _isListening = false;
  String _voiceInput = '';

  @override
  void initState() {
    super.initState();
    _aiService = AISearchService(apiService: ApiService());
    _speech = stt.SpeechToText();
    
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.05).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeIn,
      ),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, -0.1),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOut,
      ),
    );

    // Initialize the service
    _aiService.initialize();
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        setState(() => _highlightedIndex = -1);
      }
    });
    _loadRecentSearches();
    _showDropdown = false;
  }

  @override
  void dispose() {
    _animationController.dispose();
    _focusNode.dispose();
    _keyboardFocusNode.dispose();
    super.dispose();
  }

  Future<void> _loadRecentSearches() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _recentSearches = prefs.getStringList(_recentSearchesKey) ?? [];
    });
  }

  Future<void> _addRecentSearch(String query) async {
    if (query.trim().isEmpty) return;
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _recentSearches.remove(query);
      _recentSearches.insert(0, query);
      if (_recentSearches.length > _maxRecent) {
        _recentSearches = _recentSearches.sublist(0, _maxRecent);
      }
      prefs.setStringList(_recentSearchesKey, _recentSearches);
    });
  }

  Future<void> _clearRecentSearches() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _recentSearches.clear();
      prefs.remove(_recentSearchesKey);
    });
  }

  void _handleProductSelection(Map<String, dynamic> product) async {
    final productId = product['id']?.toString() ?? product['_id']?.toString();
    print('🛒 Selected product ID: $productId');
    if (productId != null && productId.isNotEmpty) {
      setState(() => _isProductLoading = true);
      final api = ApiService();
      final fullProductJson = await api.getProductById(productId);
      print('🛒 Fetched product details: $fullProductJson');
      setState(() => _isProductLoading = false);
      if (fullProductJson != null) {
        try {
          final fullProduct = ProductsViewsModel.fromJson(fullProductJson);
          Navigator.pushNamed(
            context,
            '/product',
            arguments: fullProduct,
          );
        } catch (e, st) {
          print('❌ Error parsing product: $e\n$st');
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Failed to load product details.')),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Product details not found.')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Product data is incomplete.')),
      );
    }
  }

  Future<void> _searchProducts(String query, {bool fromSuggestion = false}) async {
    if (query.isEmpty) {
      setState(() {
        _searchResults = [];
        _suggestions = [];
        _showDropdown = false;
      });
      return;
    }

    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () async {
      await _addRecentSearch(query);
      setState(() {
        _isLoading = true;
        _showDropdown = true;
      });

      if (_searchCache.containsKey(query)) {
        final cachedResults = _searchCache[query]!;
        // Filter and sort cached results
        final filtered = _filterAndSortResults(cachedResults, query);
        setState(() {
          _searchResults = filtered;
          _isLoading = false;
          _showDropdown = true;
        });
        print('⚡️ Used cached results for "$query"');
        return;
      }

      try {
        print('🔍 Starting search for: $query');
        final suggestions = await _aiService.fetchLiveSuggestions(query);
        print('📝 Received ${suggestions.length} suggestions');
        final results = await _aiService.searchProducts(query);
        print('📦 Received ${results.length} search results');
        if (mounted) {
          print('🔄 Processing search results...');
          final processedResults = results.map((result) {
            final processed = {
              'id': result['id'] ?? result['_id'] ?? '',
              'title': result['title'] ?? result['name'] ?? '',
              'price': result['price'] ?? 0.0,
              'images': result['images'] ?? result['imagePaths'] ?? [],
              'brand': result['brand'] ?? '',
              'category': result['category'] ?? '',
              'description': result['description'] ?? result['aboutThisItem'] ?? '',
              'rating': result['rating'] ?? result['ratingsAverage'] ?? 0.0,
              'reviewCount': result['reviewCount'] ?? result['ratingsQuantity'] ?? 0,
            };
            return processed;
          }).toList();
          _searchCache[query] = processedResults;
          // Filter and sort results
          final filtered = _filterAndSortResults(processedResults, query);
          setState(() {
            _suggestions = suggestions;
            _searchResults = filtered;
            _isLoading = false;
            _showDropdown = true;
          });
          print('✅ State updated successfully');
        }
      } catch (e, stackTrace) {
        print('❌ Error searching products: $e');
        print('❌ Stack trace: $stackTrace');
        if (mounted) {
          setState(() {
            _isLoading = false;
            _showDropdown = true;
          });
        }
      }
    });
  }

  List<Map<String, dynamic>> _filterAndSortResults(List<Map<String, dynamic>> results, String query) {
    final lowerQuery = query.toLowerCase();
    final filtered = results.where((item) {
      final title = (item['title'] ?? '').toString().toLowerCase();
      return title.contains(lowerQuery);
    }).toList();
    filtered.sort((a, b) {
      final aTitle = (a['title'] ?? '').toString().toLowerCase();
      final bTitle = (b['title'] ?? '').toString().toLowerCase();
      final aIdx = aTitle.indexOf(lowerQuery);
      final bIdx = bTitle.indexOf(lowerQuery);
      if (aIdx == bIdx) {
        return aTitle.compareTo(bTitle);
      }
      return aIdx.compareTo(bIdx);
    });
    return filtered;
  }

  void _handleKey(RawKeyEvent event) {
    final total = _suggestions.length + _searchResults.length + _categories.length + _popularSearches.length + _recentSearches.length;
    if (event is RawKeyDownEvent) {
      if (event.logicalKey == LogicalKeyboardKey.arrowDown) {
        setState(() {
          _highlightedIndex = (_highlightedIndex + 1) % max(total, 1).toInt();
        });
      } else if (event.logicalKey == LogicalKeyboardKey.arrowUp) {
        setState(() {
          _highlightedIndex = (_highlightedIndex - 1 + max(total, 1).toInt()) % max(total, 1).toInt();
        });
      } else if (event.logicalKey == LogicalKeyboardKey.enter) {
        if (_highlightedIndex >= 0 && _highlightedIndex < _suggestions.length) {
          final suggestion = _suggestions[_highlightedIndex];
          widget.controller.text = suggestion;
          widget.onSearch(suggestion);
          _searchProducts(suggestion);
        } else if (_highlightedIndex >= _suggestions.length && _highlightedIndex < total) {
          final result = _searchResults[_highlightedIndex - _suggestions.length];
          _handleProductSelection(result);
        }
      } else if (event.logicalKey == LogicalKeyboardKey.escape) {
        _handleEscape();
      }
    }
  }

  void _handleEscape() {
    setState(() {
      _showDropdown = false;
      _highlightedIndex = -1;
      _focusNode.unfocus();
      _keyboardFocusNode.unfocus();
    });
  }

  Widget _highlightText(String text, String query) {
    if (query.isEmpty) return Text(text, style: TextStyles.regular16);
    final lowerText = text.toLowerCase();
    final lowerQuery = query.toLowerCase();
    final spans = <TextSpan>[];
    int start = 0;
    int idx = lowerText.indexOf(lowerQuery);
    while (idx != -1) {
      if (idx > start) {
        spans.add(TextSpan(text: text.substring(start, idx), style: TextStyles.regular16));
      }
      spans.add(TextSpan(
        text: text.substring(idx, idx + lowerQuery.length),
        style: TextStyles.bold16.copyWith(backgroundColor: Colors.yellow.shade300),
      ));
      start = idx + lowerQuery.length;
      idx = lowerText.indexOf(lowerQuery, start);
    }
    if (start < text.length) {
      spans.add(TextSpan(text: text.substring(start), style: TextStyles.regular16));
    }
    return RichText(text: TextSpan(children: spans));
  }

  Widget _buildSectionHeader(String title, {IconData? icon}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        children: [
          if (icon != null) Icon(icon, size: 18, color: Colors.grey),
          if (icon != null) const SizedBox(width: 6),
          Text(title, style: TextStyles.bold16.copyWith(color: Colors.grey[700])),
        ],
      ),
    );
  }

  Future<void> _listenVoice() async {
    // Check and request permission only if not already granted
    var micStatus = await Permission.microphone.status;
    if (!micStatus.isGranted) {
      micStatus = await Permission.microphone.request();
      if (!micStatus.isGranted) {
        if (context.mounted) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Microphone Permission Required'),
              content: const Text('To use voice search, please allow microphone access.'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('OK'),
                ),
              ],
            ),
          );
        }
        return;
      }
    }

    // Initialize SpeechToText only if not already available
    if (!_isListening) {
      bool available = await _speech!.initialize(
        onStatus: (val) => print('🗣️ Voice status: $val'),
        onError: (val) => print('❌ Voice error: $val'),
      );
      if (!available || _speech!.hasPermission != true) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Microphone permission not granted or speech recognition unavailable.')),
          );
        }
        return;
      }
      setState(() => _isListening = true);
      _speech!.listen(
        onResult: (val) {
          setState(() {
            _voiceInput = val.recognizedWords;
            widget.controller.text = _voiceInput;
          });
          if (val.hasConfidenceRating && val.confidence > 0) {
            _searchProducts(_voiceInput);
          }
        },
      );
    } else {
      setState(() => _isListening = false);
      _speech!.stop();
    }
  }

  Widget _buildVoiceIcon() {
    return IconButton(
      icon: Icon(_isListening ? Icons.mic : Icons.mic_none, color: Colors.blueAccent),
      onPressed: _listenVoice,
      tooltip: 'Voice Search',
    );
  }

  Widget _buildFilterChips() {
    return Wrap(
      spacing: 8,
      children: [
        FilterChip(
          label: const Text('Price < 100'),
          selected: _filters.contains('price100'),
          onSelected: (v) => setState(() {
            if (v) {
              _filters.add('price100');
            } else {
              _filters.remove('price100');
            }
          }),
        ),
        FilterChip(
          label: const Text('Brand: Apple'),
          selected: _filters.contains('apple'),
          onSelected: (v) => setState(() {
            if (v) {
              _filters.add('apple');
            } else {
              _filters.remove('apple');
            }
          }),
        ),
        FilterChip(
          label: const Text('Rating 4+'),
          selected: _filters.contains('rating4'),
          onSelected: (v) => setState(() {
            if (v) {
              _filters.add('rating4');
            } else {
              _filters.remove('rating4');
            }
          }),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final containerColor = isDarkMode ? Colors.grey[800] : Colors.grey.shade100;
    final borderColor = isDarkMode ? Colors.grey[700] : Colors.grey.shade400;
    final primaryColor = Theme.of(context).colorScheme.primary;
    final query = widget.controller.text;
    final showRecent = _isFocused && widget.controller.text.isEmpty && _recentSearches.isNotEmpty;

    print('🎨 Building UI with:');
    print('  - Query: $query');
    print('  - Show dropdown: $_showDropdown');
    print('  - Search results: ${_searchResults.length}');
    print('  - Suggestions: ${_suggestions.length}');
    print('  - Is focused: $_isFocused');
    print('  - Is loading: $_isLoading');

    return RawKeyboardListener(
      focusNode: _keyboardFocusNode,
      onKey: _handleKey,
      child: Column(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeInOut,
            margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(32),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.12),
                  blurRadius: 16,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    focusNode: _focusNode,
                    controller: widget.controller,
                    onChanged: (value) {
                      print('📝 Text changed: $value');
                      _debounce?.cancel();
                      _searchProducts(value);
                      setState(() {
                        _highlightedIndex = -1;
                        _showDropdown = true;
                      });
                    },
                    onSubmitted: (value) {
                      print('🔍 Search submitted: $value');
                      widget.onSearch(value);
                      _searchProducts(value);
                    },
                    onTap: () {
                      print('👆 Text field tapped');
                      setState(() {
                        _isFocused = true;
                        _showDropdown = true;
                      });
                    },
                    textInputAction: TextInputAction.search,
                    keyboardType: TextInputType.text,
                    style: TextStyles.regular16.copyWith(
                      color: isDarkMode ? Colors.white : Colors.black,
                    ),
                    decoration: InputDecoration(
                      isCollapsed: true,
                      contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                      hintStyle: TextStyles.regular16.copyWith(
                        color: isDarkMode ? Colors.grey[400] : const Color(0xFF949D9E),
                      ),
                      hintText: 'Search for products, brands, categories...',
                      filled: true,
                      fillColor: Colors.transparent,
                      prefixIcon: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 200),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Image.asset(
                            Assets.search,
                            width: 20,
                            height: 20,
                            fit: BoxFit.contain,
                            color: _isFocused ? primaryColor : (isDarkMode ? Colors.grey[400] : null),
                          ),
                        ),
                      ),
                      prefixIconConstraints: const BoxConstraints(
                        minWidth: 48,
                        minHeight: 48,
                      ),
                      suffixIcon: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _buildVoiceIcon(),
                          if (widget.controller.text.isNotEmpty)
                            IconButton(
                              key: const ValueKey('clear'),
                              icon: Icon(
                                Icons.clear,
                                color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
                              ),
                              onPressed: () {
                                print('🗑️ Clear button pressed');
                                widget.controller.clear();
                                setState(() {
                                  _searchResults = [];
                                  _suggestions = [];
                                  _highlightedIndex = -1;
                                  _showDropdown = false;
                                });
                              },
                            ),
                        ],
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32),
                        borderSide: BorderSide(
                          color: _isFocused ? primaryColor : borderColor!,
                          width: 1,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32),
                        borderSide: BorderSide(
                          color: _isFocused ? primaryColor : borderColor!,
                          width: 1,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32),
                        borderSide: BorderSide(
                          color: primaryColor,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
              ],
            ),
          ),
          if (_filters.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              child: _buildFilterChips(),
            ),
          if (_isLoading)
            const Padding(
              padding: EdgeInsets.all(12.0),
              child: Center(child: CircularProgressIndicator()),
            ),
          if (!_isLoading && _suggestions.isEmpty && _searchResults.isEmpty && widget.controller.text.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text('No results found', style: TextStyles.regular16),
            ),
          if (_showDropdown && (_suggestions.isNotEmpty || _searchResults.isNotEmpty || showRecent))
            SizedBox(
              height: 400, // Limit dropdown height
              child: Container(
                margin: const EdgeInsets.only(top: 8),
                decoration: BoxDecoration(
                  color: isDarkMode ? Colors.grey[800] : Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (showRecent) ...[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildSectionHeader('Recent Searches', icon: Icons.history),
                            TextButton(
                              onPressed: _clearRecentSearches,
                              child: const Text('Clear All'),
                            ),
                          ],
                        ),
                        ..._recentSearches.map((recent) => Dismissible(
                              key: ValueKey(recent),
                              direction: DismissDirection.endToStart,
                              background: Container(
                                color: Colors.red,
                                alignment: Alignment.centerRight,
                                padding: const EdgeInsets.symmetric(horizontal: 20),
                                child: const Icon(Icons.delete, color: Colors.white),
                              ),
                              onDismissed: (direction) async {
                                setState(() => _recentSearches.remove(recent));
                                final prefs = await SharedPreferences.getInstance();
                                prefs.setStringList(_recentSearchesKey, _recentSearches);
                              },
                              child: ListTile(
                                leading: const Icon(Icons.history),
                                title: Text(recent, style: TextStyles.regular16),
                                trailing: IconButton(
                                  icon: const Icon(Icons.close, size: 18),
                                  onPressed: () async {
                                    setState(() => _recentSearches.remove(recent));
                                    final prefs = await SharedPreferences.getInstance();
                                    prefs.setStringList(_recentSearchesKey, _recentSearches);
                                  },
                                ),
                                onTap: () {
                                  widget.controller.text = recent;
                                  _searchProducts(recent);
                                },
                              ),
                            )),
                      ],
                      if (_suggestions.isNotEmpty) ...[
                        _buildSectionHeader('Suggestions', icon: Icons.search),
                        ..._suggestions.take(3).toList().asMap().entries.map((entry) {
                          final idx = entry.key;
                          final suggestion = entry.value;
                          if (suggestion.trim().isEmpty) return SizedBox.shrink();
                          return Material(
                            color: _highlightedIndex == idx ? primaryColor.withOpacity(0.1) : Colors.transparent,
                            child: ListTile(
                              leading: const Icon(Icons.search),
                              title: Text(suggestion, style: TextStyles.regular16),
                              trailing: IconButton(
                                icon: const Icon(Icons.close, size: 18),
                                onPressed: () {
                                  setState(() {
                                    _suggestions.removeAt(idx);
                                  });
                                },
                              ),
                              onTap: () {
                                _debounce?.cancel();
                                _searchProducts(suggestion, fromSuggestion: true);
                              },
                              selected: _highlightedIndex == idx,
                            ),
                          );
                        }),
                      ],
                      if (_searchResults.isNotEmpty) ...[
                        _buildSectionHeader('Results', icon: Icons.shopping_bag),
                        ..._searchResults.asMap().entries.map((entry) {
                          final idx = entry.key + _suggestions.length;
                          final result = entry.value;
                          print('🎯 Building result item: ${result['title']}');
                          return Material(
                            color: _highlightedIndex == idx ? primaryColor.withOpacity(0.1) : Colors.transparent,
                            child: ListTile(
                              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                              leading: result['images'] != null && result['images'].isNotEmpty
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.network(
                                        result['images'][0],
                                        width: 48,
                                        height: 48,
                                        fit: BoxFit.cover,
                                        errorBuilder: (context, error, stackTrace) =>
                                            Container(
                                              width: 48,
                                              height: 48,
                                              decoration: BoxDecoration(
                                                color: Colors.grey[200],
                                                borderRadius: BorderRadius.circular(8),
                                              ),
                                              child: const Icon(Icons.image_not_supported, color: Colors.grey),
                                            ),
                                      ),
                                    )
                                  : Container(
                                      width: 48,
                                      height: 48,
                                      decoration: BoxDecoration(
                                        color: Colors.grey[200],
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: const Icon(Icons.image_not_supported, color: Colors.grey),
                                    ),
                              title: _highlightText(result['title'] ?? 'No title', widget.controller.text),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 4),
                                  if ((result['price'] ?? 0) > 0)
                                    Text(
                                      '₹${result['price'].toStringAsFixed(2)}',
                                      style: TextStyles.bold16.copyWith(
                                        color: primaryColor,
                                      ),
                                    ),
                                  if ((result['brand'] ?? '').toString().isNotEmpty) ...[
                                    const SizedBox(height: 2),
                                    Text(
                                      'Brand: ${result['brand']}',
                                      style: TextStyles.regular16.copyWith(color: Colors.grey[600]),
                                    ),
                                  ],
                                  if ((result['category'] ?? '').toString().isNotEmpty) ...[
                                    const SizedBox(height: 2),
                                    Text(
                                      'Category: ${result['category']}',
                                      style: TextStyles.regular16.copyWith(color: Colors.grey[600]),
                                    ),
                                  ],
                                  if ((result['rating'] ?? 0) > 0) ...[
                                    const SizedBox(height: 2),
                                    Row(
                                      children: [
                                        Icon(Icons.star, size: 16, color: Colors.amber),
                                        const SizedBox(width: 4),
                                        Text(
                                          '${result['rating']} (${result['reviewCount']} reviews)',
                                          style: TextStyles.regular16.copyWith(color: Colors.grey[600]),
                                        ),
                                      ],
                                    ),
                                  ],
                                ],
                              ),
                              onTap: () => _handleProductSelection(result),
                              selected: _highlightedIndex == idx,
                            ),
                          );
                        }),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          if (_isProductLoading)
            const Center(child: CircularProgressIndicator()),
        ],
      ),
    );
  }
}
