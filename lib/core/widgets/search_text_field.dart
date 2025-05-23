import 'package:flutter/material.dart';
import 'package:pickpay/core/utils/app_images.dart';
import 'package:pickpay/core/utils/app_text_styles.dart';
import 'package:pickpay/core/services/ai_search_service.dart';
import 'package:pickpay/services/api_service.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math';
import 'package:flutter/gestures.dart';

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

  @override
  void initState() {
    super.initState();
    _aiService = AISearchService(apiService: ApiService());
    
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

  void _handleProductSelection(Map<String, dynamic> product) {
    // Call the onProductSelected callback if provided
    if (widget.onProductSelected != null) {
      widget.onProductSelected!(product);
    } else {
      // Default navigation behavior
      final productId = product['id']?.toString();
      if (productId != null && productId.isNotEmpty) {
        Navigator.pushNamed(
          context,
          '/product',
          arguments: product,
        );
      }
    }
  }

  Future<void> _searchProducts(String query) async {
    if (query.isEmpty) {
      setState(() {
        _searchResults = [];
        _suggestions = [];
      });
      return;
    }
    await _addRecentSearch(query);
    setState(() => _isLoading = true);
    try {
      // Get suggestions first
      final suggestions = _aiService.getSuggestions(query);
      setState(() => _suggestions = suggestions);

      // Then get search results
      final results = await _aiService.searchProducts(query);
      setState(() => _searchResults = results);
    } catch (e) {
      print('Error searching products: $e');
    } finally {
      setState(() => _isLoading = false);
    }
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

  Widget _buildVoiceIcon() {
    return IconButton(
      icon: const Icon(Icons.mic, color: Colors.blueAccent),
      onPressed: () {
        // Placeholder for voice search logic
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Voice search coming soon!')));
      },
      tooltip: 'Voice Search',
    );
  }

  Widget _buildBarcodeIcon() {
    return IconButton(
      icon: const Icon(Icons.qr_code_scanner, color: Colors.green),
      onPressed: () {
        // Placeholder for barcode scan logic
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Barcode scan coming soon!')));
      },
      tooltip: 'Scan Barcode',
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
                      Future.delayed(const Duration(milliseconds: 200), () {
                        if (value == widget.controller.text) {
                          _searchProducts(value);
                          setState(() => _highlightedIndex = -1);
                          setState(() => _showDropdown = true);
                        }
                      });
                    },
                    onSubmitted: (value) {
                      widget.onSearch(value);
                      _searchProducts(value);
                    },
                    textInputAction: TextInputAction.search,
                    keyboardType: TextInputType.text,
                    style: TextStyles.regular16.copyWith(
                      color: Theme.of(context).textTheme.bodyLarge?.color,
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
                          _buildBarcodeIcon(),
                          if (widget.controller.text.isNotEmpty)
                            IconButton(
                              key: const ValueKey('clear'),
                              icon: Icon(
                                Icons.clear,
                                color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
                              ),
                              onPressed: () {
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
          if (_showDropdown && (_suggestions.isNotEmpty || _searchResults.isNotEmpty || _recentSearches.isNotEmpty || _categories.isNotEmpty || _popularSearches.isNotEmpty))
            SlideTransition(
              position: _slideAnimation,
              child: FadeTransition(
                opacity: _opacityAnimation,
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
                        if (_recentSearches.isNotEmpty)
                          _buildSectionHeader('Recent Searches', icon: Icons.history),
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
                                onTap: () {
                                  widget.controller.text = recent;
                                  _searchProducts(recent);
                                },
                              ),
                            )),
                        if (_popularSearches.isNotEmpty)
                          _buildSectionHeader('Popular Searches', icon: Icons.trending_up),
                        ..._popularSearches.map((pop) => ListTile(
                              leading: const Icon(Icons.trending_up),
                              title: _highlightText(pop, widget.controller.text),
                              onTap: () {
                                widget.controller.text = pop;
                                _searchProducts(pop);
                              },
                            )),
                        if (_categories.isNotEmpty)
                          _buildSectionHeader('Categories', icon: Icons.category),
                        ..._categories.map((cat) => ListTile(
                              leading: const Icon(Icons.category),
                              title: _highlightText(cat, widget.controller.text),
                              onTap: () {
                                setState(() => _selectedCategory = cat);
                                widget.controller.text = cat;
                                _searchProducts(cat);
                              },
                            )),
                        if (_suggestions.isNotEmpty)
                          _buildSectionHeader('Suggestions', icon: Icons.search),
                        ..._suggestions.asMap().entries.map((entry) {
                          final idx = entry.key;
                          final suggestion = entry.value;
                          return Material(
                            color: _highlightedIndex == idx ? primaryColor.withOpacity(0.1) : Colors.transparent,
                            child: ListTile(
                              leading: const Icon(Icons.search),
                              title: _highlightText(suggestion, widget.controller.text),
                              onTap: () {
                                widget.controller.text = suggestion;
                                widget.onSearch(suggestion);
                                _searchProducts(suggestion);
                              },
                              selected: _highlightedIndex == idx,
                            ),
                          );
                        }),
                        if (_searchResults.isNotEmpty)
                          _buildSectionHeader('Results', icon: Icons.shopping_bag),
                        ..._searchResults.asMap().entries.map((entry) {
                          final idx = entry.key + _suggestions.length;
                          final result = entry.value;
                          return Material(
                            color: _highlightedIndex == idx ? primaryColor.withOpacity(0.1) : Colors.transparent,
                            child: ListTile(
                              leading: result['image'] != null && result['image'].toString().isNotEmpty
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.network(
                                        result['image'],
                                        width: 40,
                                        height: 40,
                                        fit: BoxFit.cover,
                                        errorBuilder: (context, error, stackTrace) =>
                                            const Icon(Icons.image_not_supported),
                                      ),
                                    )
                                  : const Icon(Icons.image_not_supported),
                              title: _highlightText(result['title'] ?? 'No title', widget.controller.text),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if ((result['brand'] ?? '').toString().isNotEmpty)
                                    Text(result['brand'], style: TextStyles.regular16.copyWith(color: Colors.grey)),
                                  if ((result['category'] ?? '').toString().isNotEmpty)
                                    Text(result['category'], style: TextStyles.regular16.copyWith(color: Colors.blueGrey)),
                                  if ((result['price'] ?? 0) > 0)
                                    Text(
                                      '\$${result['price'].toStringAsFixed(2)}',
                                      style: TextStyles.bold16.copyWith(color: primaryColor),
                                    ),
                                  if ((result['description'] ?? '').toString().isNotEmpty)
                                    Text(
                                      result['description'],
                                      style: TextStyles.regular16,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                ],
                              ),
                              onTap: () => _handleProductSelection(result),
                              selected: _highlightedIndex == idx,
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
