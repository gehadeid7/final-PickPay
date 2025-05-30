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

class _SearchTextFieldState extends State<SearchTextField>
    with TickerProviderStateMixin {
  late final AISearchService _aiService;
  List<Map<String, dynamic>> _searchResults = [];
  List<String> _suggestions = [];
  bool _isLoading = false;
  bool _isFocused = false;
  late AnimationController _animationController;
  late AnimationController _pulseController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<Color?> _colorAnimation;
  int _highlightedIndex = -1;
  final FocusNode _focusNode = FocusNode();
  final FocusNode _keyboardFocusNode = FocusNode();
  List<String> _recentSearches = [];
  static const String _recentSearchesKey = 'recent_searches';
  static const int _maxRecent = 8;
  
  // Enhanced categories with better coverage
  final List<String> _categories = [
    'Electronics',
    'Fashion',
    'Home & Garden',
    'Beauty',
    'Sports',
    'Books',
    'Grocery',
    'Toys',
    'Automotive',
    'Health'
  ];
  
  // Updated popular searches
  final List<String> _popularSearches = [
    'iPhone 15 Pro',
    'MacBook Pro',
    'AirPods',
    'Samsung Galaxy',
    'Nike Shoes',
    'PlayStation 5',
    'Coffee Machine',
    'Bluetooth Speaker',
    'Smart Watch',
    'Wireless Charger'
  ];
  
  String? _selectedCategory;
  List<String> _filters = [];
  bool _showDropdown = false;
  Timer? _debounce;
  final Map<String, List<Map<String, dynamic>>> _searchCache = {};
  bool _isProductLoading = false;
  String _lastSearchQuery = '';
  
  // Enhanced voice search
  stt.SpeechToText? _speech;
  bool _isListening = false;
  String _voiceInput = '';
  bool _speechAvailable = false;
  
  // Performance optimizations
  static const Duration _debounceDelay = Duration(milliseconds: 300);
  static const Duration _animationDuration = Duration(milliseconds: 250);
  static const int _maxCacheSize = 100;
  static const int _maxResultsToShow = 15;

  @override
  void initState() {
    super.initState();
    _initializeServices();
    _setupAnimations();
    _setupFocusListeners();
    _loadRecentSearches();
    _initializeSpeech();
  }

  void _initializeServices() {
    try {
      _aiService = AISearchService(apiService: ApiService());
      _aiService.initialize().catchError((error) {
        print('❌ Failed to initialize AI service: $error');
      });
    } catch (e) {
      print('❌ Error initializing AI service: $e');
    }
  }

  void _setupAnimations() {
    _animationController = AnimationController(
      duration: _animationDuration,
      vsync: this,
    );

    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.02).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, -0.1),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutBack),
    );

    _colorAnimation = ColorTween(
      begin: Colors.grey[300],
      end: Colors.blue[400],
    ).animate(_pulseController);

    _pulseController.repeat(reverse: true);
  }

  void _setupFocusListeners() {
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
        if (!_isFocused) {
          _highlightedIndex = -1;
          _showDropdown = false;
          _animationController.reverse();
        } else {
          _showDropdown = true;
          _animationController.forward();
        }
      });
    });
  }

  Future<void> _initializeSpeech() async {
    try {
      _speech = stt.SpeechToText();
      _speechAvailable = await _speech!.initialize(
        onStatus: _onSpeechStatus,
        onError: _onSpeechError,
      );
      print('🎤 Speech recognition available: $_speechAvailable');
    } catch (e) {
      print('❌ Speech initialization error: $e');
      _speechAvailable = false;
    }
  }

  void _onSpeechStatus(String status) {
    print('🎤 Speech status: $status');
    if (status == 'done' || status == 'notListening') {
      setState(() => _isListening = false);
    }
  }

  void _onSpeechError(dynamic error) {
    print('❌ Speech error: $error');
    setState(() => _isListening = false);
    if (mounted) {
      _showSnackBar('Voice search error. Please try again.', isError: true);
    }
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _animationController.dispose();
    _pulseController.dispose();
    _focusNode.dispose();
    _keyboardFocusNode.dispose();
    _speech?.stop();
    super.dispose();
  }

  // Enhanced recent searches management
  Future<void> _loadRecentSearches() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final searches = prefs.getStringList(_recentSearchesKey) ?? [];
      if (mounted) {
        setState(() => _recentSearches = searches);
      }
    } catch (e) {
      print('❌ Error loading recent searches: $e');
    }
  }

  Future<void> _addRecentSearch(String query) async {
    if (query.trim().isEmpty) return;
    
    try {
      final prefs = await SharedPreferences.getInstance();
      final trimmedQuery = query.trim();
      
      setState(() {
        _recentSearches.remove(trimmedQuery);
        _recentSearches.insert(0, trimmedQuery);
        if (_recentSearches.length > _maxRecent) {
          _recentSearches = _recentSearches.sublist(0, _maxRecent);
        }
      });
      
      await prefs.setStringList(_recentSearchesKey, _recentSearches);
    } catch (e) {
      print('❌ Error adding recent search: $e');
    }
  }

  Future<void> _clearRecentSearches() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      setState(() => _recentSearches.clear());
      await prefs.remove(_recentSearchesKey);
    } catch (e) {
      print('❌ Error clearing recent searches: $e');
    }
  }

  // Enhanced product selection with better error handling
  void _handleProductSelection(Map<String, dynamic> product) async {
    final productId = product['id']?.toString() ?? 
                     product['_id']?.toString() ?? 
                     product['productId']?.toString();
    
    if (productId == null || productId.isEmpty) {
      _showSnackBar('Product information is incomplete', isError: true);
      return;
    }

    setState(() => _isProductLoading = true);
    
    try {
      final api = ApiService();
      final fullProductJson = await api.getProductById(productId);
      
      if (fullProductJson != null && mounted) {
        final fullProduct = ProductsViewsModel.fromJson(fullProductJson);
        Navigator.pushNamed(context, '/product', arguments: fullProduct);
        setState(() => _showDropdown = false);
        _focusNode.unfocus();
      } else {
        _showSnackBar('Product details not found', isError: true);
      }
    } catch (e) {
      print('❌ Error loading product: $e');
      _showSnackBar('Failed to load product details', isError: true);
    } finally {
      if (mounted) {
        setState(() => _isProductLoading = false);
      }
    }
  }

  void _showSnackBar(String message, {bool isError = false}) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: isError ? Colors.red[600] : Colors.green[600],
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: isError ? 4 : 2),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );
    }
  }

  // Enhanced search with better performance and error handling
  Future<void> _searchProducts(String query, {bool fromSuggestion = false}) async {
    final trimmedQuery = query.trim();
    
    if (trimmedQuery.isEmpty) {
      _clearSearchState();
      return;
    }

    // Prevent duplicate searches
    if (trimmedQuery == _lastSearchQuery && !fromSuggestion) {
      return;
    }
    _lastSearchQuery = trimmedQuery;

    // Cancel previous debounce
    _debounce?.cancel();
    
    // Immediate UI feedback for better UX
    if (!_isLoading) {
      setState(() {
        _isLoading = true;
        _showDropdown = true;
      });
    }
    
    _debounce = Timer(_debounceDelay, () async {
      if (!mounted) return;
      
      try {
        await _addRecentSearch(trimmedQuery);
        
        // Check cache first for instant results
        final cacheKey = trimmedQuery.toLowerCase();
        if (_searchCache.containsKey(cacheKey)) {
          final cachedResults = _searchCache[cacheKey]!;
          if (mounted) {
            setState(() {
              _searchResults = cachedResults.take(_maxResultsToShow).toList();
              _isLoading = false;
            });
          }
          return;
        }

        // Parallel fetch for better performance
        final futures = <Future>[];
        
        // Get suggestions
        futures.add(_aiService.fetchLiveSuggestions(trimmedQuery));
        
        // Get search results
        futures.add(_aiService.searchProducts(trimmedQuery));

        final results = await Future.wait(futures);
        
        if (mounted) {
          final suggestions = results[0] as List<String>;
          final searchResults = results[1] as List<Map<String, dynamic>>;

          // Process and cache results
          final processedResults = _processSearchResults(searchResults);
          _updateCache(cacheKey, processedResults);
          
          setState(() {
            _suggestions = suggestions.take(5).toList();
            _searchResults = processedResults.take(_maxResultsToShow).toList();
            _isLoading = false;
          });
        }
      } catch (e) {
        print('❌ Search error: $e');
        if (mounted) {
          setState(() => _isLoading = false);
          _showSnackBar('Search failed. Please check your connection.', isError: true);
        }
      }
    });
  }

  void _clearSearchState() {
    setState(() {
      _searchResults = [];
      _suggestions = [];
      _showDropdown = false;
      _isLoading = false;
      _lastSearchQuery = '';
    });
  }

  List<Map<String, dynamic>> _processSearchResults(List<Map<String, dynamic>> results) {
    return results.map((result) {
      // Ensure all required fields are present with fallbacks
      return {
        'id': result['id'] ?? result['_id'] ?? result['productId'] ?? '',
        'title': result['title'] ?? result['name'] ?? result['productName'] ?? 'Unknown Product',
        'price': _parsePrice(result['price']),
        'images': _parseImages(result['images'] ?? result['imagePaths'] ?? result['imageUrls']),
        'brand': result['brand'] ?? result['manufacturer'] ?? '',
        'category': result['category'] ?? result['categoryName'] ?? '',
        'description': result['description'] ?? result['aboutThisItem'] ?? result['summary'] ?? '',
        'rating': _parseRating(result['rating'] ?? result['ratingsAverage']),
        'reviewCount': _parseReviewCount(result['reviewCount'] ?? result['ratingsQuantity']),
        'inStock': result['inStock'] ?? result['stock'] ?? true,
        'discount': _parseDiscount(result['discount'] ?? result['discountPercentage']),
      };
    }).where((item) => item['title'] != 'Unknown Product').toList();
  }

  double _parsePrice(dynamic price) {
    if (price == null) return 0.0;
    if (price is num) return price.toDouble();
    if (price is String) {
      final cleanPrice = price.replaceAll(RegExp(r'[^\d.]'), '');
      return double.tryParse(cleanPrice) ?? 0.0;
    }
    return 0.0;
  }

  List<String> _parseImages(dynamic images) {
    if (images == null) return [];
    if (images is List) return images.map((img) => img.toString()).where((img) => img.isNotEmpty).toList();
    if (images is String && images.isNotEmpty) return [images];
    return [];
  }

  double _parseRating(dynamic rating) {
    if (rating == null) return 0.0;
    if (rating is num) return rating.toDouble();
    if (rating is String) return double.tryParse(rating) ?? 0.0;
    return 0.0;
  }

  int _parseReviewCount(dynamic count) {
    if (count == null) return 0;
    if (count is int) return count;
    if (count is String) return int.tryParse(count) ?? 0;
    if (count is double) return count.toInt();
    return 0;
  }

  double _parseDiscount(dynamic discount) {
    if (discount == null) return 0.0;
    if (discount is num) return discount.toDouble();
    if (discount is String) return double.tryParse(discount) ?? 0.0;
    return 0.0;
  }

  void _updateCache(String query, List<Map<String, dynamic>> results) {
    _searchCache[query] = results;
    
    // Limit cache size for memory management
    if (_searchCache.length > _maxCacheSize) {
      final oldestKey = _searchCache.keys.first;
      _searchCache.remove(oldestKey);
    }
  }

  // Enhanced keyboard navigation
  void _handleKey(RawKeyEvent event) {
    if (event is! RawKeyDownEvent || !_showDropdown) return;
    
    final totalItems = _getTotalDropdownItems();
    
    if (totalItems == 0) return;
    
    if (event.logicalKey == LogicalKeyboardKey.arrowDown) {
      setState(() {
        _highlightedIndex = (_highlightedIndex + 1) % totalItems;
      });
    } else if (event.logicalKey == LogicalKeyboardKey.arrowUp) {
      setState(() {
        _highlightedIndex = (_highlightedIndex - 1 + totalItems) % totalItems;
      });
    } else if (event.logicalKey == LogicalKeyboardKey.enter) {
      _handleEnterKey();
    } else if (event.logicalKey == LogicalKeyboardKey.escape) {
      _handleEscape();
    }
  }

  int _getTotalDropdownItems() {
    int total = 0;
    if (_recentSearches.isNotEmpty && widget.controller.text.isEmpty && _isFocused) {
      total += _recentSearches.length;
    }
    total += _suggestions.length + _searchResults.length;
    return total;
  }

  void _handleEnterKey() {
    if (_highlightedIndex < 0) {
      // If no item is highlighted, search with current text
      final query = widget.controller.text.trim();
      if (query.isNotEmpty) {
        widget.onSearch(query);
        _searchProducts(query);
      }
      return;
    }
    
    int currentIndex = 0;
    
    // Check recent searches
    if (_recentSearches.isNotEmpty && widget.controller.text.isEmpty && _isFocused) {
      if (_highlightedIndex < _recentSearches.length) {
        final recent = _recentSearches[_highlightedIndex];
        widget.controller.text = recent;
        _searchProducts(recent);
        return;
      }
      currentIndex += _recentSearches.length;
    }
    
    // Check suggestions
    if (_highlightedIndex < currentIndex + _suggestions.length) {
      final suggestionIndex = _highlightedIndex - currentIndex;
      final suggestion = _suggestions[suggestionIndex];
      widget.controller.text = suggestion;
      _searchProducts(suggestion, fromSuggestion: true);
      return;
    }
    currentIndex += _suggestions.length;
    
    // Check search results
    if (_highlightedIndex < currentIndex + _searchResults.length) {
      final resultIndex = _highlightedIndex - currentIndex;
      final result = _searchResults[resultIndex];
      _handleProductSelection(result);
    }
  }

  void _handleEscape() {
    setState(() {
      _showDropdown = false;
      _highlightedIndex = -1;
    });
    _focusNode.unfocus();
  }

  // Enhanced voice search
  Future<void> _listenVoice() async {
    if (!_speechAvailable) {
      _showSnackBar('Voice search is not available on this device', isError: true);
      return;
    }

    final status = await Permission.microphone.request();
    if (!status.isGranted) {
      _showPermissionDialog();
      return;
    }

    try {
      if (_isListening) {
        await _speech!.stop();
        setState(() => _isListening = false);
      } else {
        setState(() => _isListening = true);
        
        await _speech!.listen(
          onResult: (result) {
            setState(() {
              _voiceInput = result.recognizedWords;
              widget.controller.text = _voiceInput;
            });
            
            if (result.finalResult && _voiceInput.isNotEmpty) {
              _searchProducts(_voiceInput);
              setState(() => _isListening = false);
            }
          },
          listenFor: const Duration(seconds: 10),
          pauseFor: const Duration(seconds: 3),
          partialResults: true,
        );
      }
    } catch (e) {
      print('❌ Voice search error: $e');
      setState(() => _isListening = false);
      _showSnackBar('Voice search failed', isError: true);
    }
  }

  void _showPermissionDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Row(
          children: [
            Icon(Icons.mic, color: Colors.blue),
            SizedBox(width: 8),
            Text('Microphone Permission'),
          ],
        ),
        content: const Text(
          'To use voice search, please allow microphone access in your device settings.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              openAppSettings();
            },
            child: const Text('Open Settings'),
          ),
        ],
      ),
    );
  }

  // Enhanced text highlighting with better contrast
  Widget _highlightText(String text, String query, {TextStyle? baseStyle}) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final baseColor = isDarkMode ? Colors.white : Colors.black87;
    if (query.isEmpty) {
      return Text(
        text,
        style: (baseStyle ?? TextStyles.regular16).copyWith(color: baseColor),
        overflow: TextOverflow.ellipsis,
      );
    }
    final lowerText = text.toLowerCase();
    final lowerQuery = query.toLowerCase();
    final spans = <TextSpan>[];
    int start = 0;
    while (start < text.length) {
      final index = lowerText.indexOf(lowerQuery, start);
      if (index == -1) {
        spans.add(TextSpan(
          text: text.substring(start),
          style: (baseStyle ?? TextStyles.regular16).copyWith(color: baseColor),
        ));
        break;
      }
      if (index > start) {
        spans.add(TextSpan(
          text: text.substring(start, index),
          style: (baseStyle ?? TextStyles.regular16).copyWith(color: baseColor),
        ));
      }
      spans.add(TextSpan(
        text: text.substring(index, index + query.length),
        style: (baseStyle ?? TextStyles.regular16).copyWith(
          backgroundColor: Colors.yellow[300],
          color: Colors.black,
          fontWeight: FontWeight.w600,
        ),
      ));
      start = index + query.length;
    }
    return RichText(
      text: TextSpan(children: spans),
      overflow: TextOverflow.ellipsis,
      maxLines: 2,
    );
  }

  Widget _buildSectionHeader(String title, {IconData? icon, Widget? action}) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              if (icon != null) ...[
                Icon(icon, size: 18, color: Colors.grey[600]),
                const SizedBox(width: 8),
              ],
              Text(
                title,
                style: TextStyles.bold16.copyWith(
                  color: Colors.grey[700],
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
          if (action != null) action,
        ],
      ),
    );
  }

  Widget _buildVoiceButton() {
    return AnimatedBuilder(
      animation: _isListening ? _pulseController : _animationController,
      builder: (context, child) => Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: _isListening ? Colors.red.withOpacity(0.1) : null,
        ),
        child: IconButton(
          icon: Icon(
            _isListening ? Icons.mic : Icons.mic_none_outlined,
            color: _isListening ? Colors.red : (_speechAvailable ? Colors.blue[600] : Colors.grey),
            size: _isListening ? 24 : 22,
          ),
          onPressed: _speechAvailable ? _listenVoice : null,
          tooltip: _speechAvailable ? 'Voice Search' : 'Voice search unavailable',
          splashRadius: 24,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final primaryColor = theme.colorScheme.primary;
    final surfaceColor = isDark ? Colors.grey[850] : Colors.white;
    final borderColor = isDark ? Colors.grey[600] : Colors.grey[300];
    final textColor = isDark ? Colors.white : Colors.black87;

    return RawKeyboardListener(
      focusNode: _keyboardFocusNode,
      onKey: _handleKey,
      child: Column(
        children: [
          // Search Input Field
          AnimatedBuilder(
            animation: _scaleAnimation,
            builder: (context, child) => Transform.scale(
              scale: _scaleAnimation.value,
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(isDark ? 0.3 : 0.1),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                      spreadRadius: 0,
                    ),
                  ],
                ),
                child: TextField(
                  focusNode: _focusNode,
                  controller: widget.controller,
                  onChanged: (value) => _searchProducts(value),
                  onSubmitted: (value) {
                    widget.onSearch(value);
                    _searchProducts(value);
                  },
                  onTap: () => setState(() => _showDropdown = true),
                  style: TextStyles.regular16.copyWith(color: textColor),
                  decoration: InputDecoration(
                    hintText: 'Search for anything...',
                    hintStyle: TextStyles.regular16.copyWith(
                      color: Colors.grey[500],
                    ),
                    prefixIcon: Container(
                      padding: const EdgeInsets.all(14),
                      child: Icon(
                        Icons.search,
                        size: 22,
                        color: _isFocused ? primaryColor : Colors.grey[600],
                      ),
                    ),
                    suffixIcon: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (_isLoading)
                          Container(
                            padding: const EdgeInsets.all(12),
                            child: SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                              ),
                            ),
                          )
                        else
                          _buildVoiceButton(),
                        if (widget.controller.text.isNotEmpty)
                          IconButton(
                            icon: Icon(Icons.clear, color: Colors.grey[600]),
                            onPressed: () {
                              widget.controller.clear();
                              _clearSearchState();
                            },
                            splashRadius: 20,
                          ),
                      ],
                    ),
                    filled: true,
                    fillColor: surfaceColor,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(color: borderColor!, width: 1),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(color: borderColor, width: 1),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(color: primaryColor, width: 2),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 16,
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Voice Search Status
          if (_isListening) _buildVoiceSearchStatus(),

          // Product Loading Indicator
          if (_isProductLoading)
            Container(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'Loading product...',
                    style: TextStyles.regular13.copyWith(color: Colors.grey[600]),
                  ),
                ],
              ),
            ),

          // Dropdown Results
          if (_showDropdown && !_isProductLoading)
            SlideTransition(
              position: _slideAnimation,
              child: FadeTransition(
                opacity: _opacityAnimation,
                child: _buildDropdownContent(isDark, primaryColor, surfaceColor, textColor),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildDropdownContent(bool isDark, Color primaryColor, Color? surfaceColor, Color textColor) {
    final showRecent = _isFocused && 
                      widget.controller.text.isEmpty && 
                      _recentSearches.isNotEmpty;
    
    if (!showRecent && _suggestions.isEmpty && _searchResults.isEmpty && !_isLoading) {
      if (widget.controller.text.isNotEmpty) {
        return _buildNoResultsWidget(textColor);
      }
      return _buildPopularSearches(primaryColor, textColor);
    }

    return Container(
      constraints: const BoxConstraints(maxHeight: 450),
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isDark ? 0.4 : 0.1),
            blurRadius: 16,
            offset: const Offset(0, 8),
            spreadRadius: 0,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Material(
          color: Colors.transparent,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Recent Searches Section
                if (showRecent) ...[
                  _buildSectionHeader(
                    'Recent Searches',
                    icon: Icons.history,
                    action: IconButton(
                      icon: Icon(Icons.clear_all, size: 18, color: Colors.grey[600]),
                      onPressed: _clearRecentSearches,
                      splashRadius: 16,
                      tooltip: 'Clear all',
                    ),
                  ),
                  ..._recentSearches.asMap().entries.map((entry) {
                    final index = entry.key;
                    final search = entry.value;
                    final globalIndex = index;
                    
                    return _buildListItem(
                      leading: Icon(Icons.history, color: Colors.grey[500], size: 20),
                      title: search,
                      onTap: () {
                        widget.controller.text = search;
                        _searchProducts(search);
                      },
                      isHighlighted: _highlightedIndex == globalIndex,
                      trailing: IconButton(
                        icon: Icon(Icons.north_west, size: 16, color: Colors.grey[500]),
                        onPressed: () => widget.controller.text = search,
                        splashRadius: 12,
                        tooltip: 'Fill search',
                      ),
                    );
                  }).toList(),
                  const Divider(height: 1),
                ],

                // Suggestions Section
                if (_suggestions.isNotEmpty) ...[
                  _buildSectionHeader('Suggestions', icon: Icons.auto_awesome),
                  ..._suggestions.asMap().entries.map((entry) {
                    final index = entry.key;
                    final suggestion = entry.value;
                    final globalIndex = (showRecent ? _recentSearches.length : 0) + index;
                    
                    return _buildListItem(
                      leading: Icon(Icons.search, color: Colors.blue[400], size: 20),
                      title: suggestion,
                      subtitle: 'Search suggestion',
                      onTap: () {
                        widget.controller.text = suggestion;
                        _searchProducts(suggestion, fromSuggestion: true);
                      },
                      isHighlighted: _highlightedIndex == globalIndex,
                      trailing: IconButton(
                        icon: Icon(Icons.north_west, size: 16, color: Colors.grey[500]),
                        onPressed: () => widget.controller.text = suggestion,
                        splashRadius: 12,
                        tooltip: 'Fill search',
                      ),
                    );
                  }).toList(),
                  if (_searchResults.isNotEmpty) const Divider(height: 1),
                ],

                // Search Results Section
                if (_searchResults.isNotEmpty) ...[
                  _buildSectionHeader('Products', icon: Icons.shopping_bag),
                  ..._searchResults.asMap().entries.map((entry) {
                    final index = entry.key;
                    final product = entry.value;
                    final globalIndex = (showRecent ? _recentSearches.length : 0) + 
                                     _suggestions.length + index;
                    
                    return _buildProductItem(
                      product: product,
                      query: widget.controller.text,
                      isHighlighted: _highlightedIndex == globalIndex,
                    );
                  }).toList(),
                ],

                // Loading indicator
                if (_isLoading) ...[
                  Container(
                    padding: const EdgeInsets.all(32),
                    child: Center(
                      child: Column(
                        children: [
                          SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'Searching...',
                            style: TextStyles.regular13.copyWith(
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildVoiceSearchStatus() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.red.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.red.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          AnimatedBuilder(
            animation: _pulseController,
            builder: (context, child) => Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                color: _colorAnimation.value,
                shape: BoxShape.circle,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Text(
            'Listening...',
            style: TextStyles.medium15.copyWith(color: Colors.red[700]),
          ),
          const Spacer(),
          TextButton(
            onPressed: () async {
              await _speech?.stop();
              setState(() => _isListening = false);
            },
            child: const Text('Stop'),
          ),
        ],
      ),
    );
  }

  Widget _buildNoResultsWidget(Color textColor) {
    return Container(
      padding: const EdgeInsets.all(32),
      child: Column(
        children: [
          Icon(
            Icons.search_off,
            size: 48,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            'No results found',
            style: TextStyles.bold16.copyWith(color: textColor),
          ),
          const SizedBox(height: 8),
          Text(
            'Try different keywords or check your spelling',
            style: TextStyles.regular13.copyWith(color: Colors.grey[600]),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildPopularSearches(Color primaryColor, Color textColor) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark 
            ? Colors.grey[850] 
            : Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader('Popular Searches', icon: Icons.trending_up),
            ..._popularSearches.take(6).map((search) => _buildListItem(
              leading: Icon(Icons.trending_up, color: primaryColor, size: 20),
              title: search,
              onTap: () {
                widget.controller.text = search;
                _searchProducts(search);
              },
            )).toList(),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  Widget _buildListItem({
    required Widget leading,
    required String title,
    String? subtitle,
    required VoidCallback onTap,
    bool isHighlighted = false,
    Widget? trailing,
  }) {
    return Material(
      color: isHighlighted 
          ? Theme.of(context).colorScheme.primary.withOpacity(0.1)
          : Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              leading,
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _highlightText(
                      title,
                      widget.controller.text,
                      baseStyle: TextStyles.medium15.copyWith(
                        color: isHighlighted 
                            ? Theme.of(context).colorScheme.primary
                            : null,
                      ),
                    ),
                    if (subtitle != null) ...[
                      const SizedBox(height: 2),
                      Text(
                        subtitle,
                        style: TextStyles.regular13.copyWith(
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              if (trailing != null) trailing,
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProductItem({
    required Map<String, dynamic> product,
    required String query,
    bool isHighlighted = false,
  }) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : Colors.black87;
    final title = product['title'] ?? 'Unknown Product';
    final price = product['price'] ?? 0.0;
    final images = product['images'] as List<String>? ?? [];
    final brand = product['brand'] ?? '';
    final rating = product['rating'] ?? 0.0;
    final reviewCount = product['reviewCount'] ?? 0;
    final discount = product['discount'] ?? 0.0;
    final inStock = product['inStock'] ?? true;

    return Material(
      color: isHighlighted 
          ? theme.colorScheme.primary.withOpacity(0.1)
          : Colors.transparent,
      child: InkWell(
        onTap: () => _handleProductSelection(product),
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product Image
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.grey[100],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: images.isNotEmpty
                      ? Image.network(
                          images.first,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => Icon(
                            Icons.image_not_supported,
                            color: Colors.grey[400],
                            size: 24,
                          ),
                        )
                      : Icon(
                          Icons.shopping_bag,
                          color: Colors.grey[400],
                          size: 24,
                        ),
                ),
              ),
              const SizedBox(width: 12),
              
              // Product Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title with highlighting
                    _highlightText(
                      title,
                      query,
                      baseStyle: TextStyles.medium15.copyWith(
                        color: isHighlighted 
                            ? theme.colorScheme.primary
                            : textColor,
                      ),
                    ),
                    if (brand.isNotEmpty) ...[
                      const SizedBox(height: 2),
                      Text(
                        brand,
                        style: TextStyles.regular13.copyWith(
                          color: isDark ? Colors.grey[300] : Colors.grey[600],
                        ),
                      ),
                    ],
                    const SizedBox(height: 4),
                    
                    // Price and discount
                    Row(
                      children: [
                        Text(
                          '\$${price.toStringAsFixed(2)}',
                          style: TextStyles.bold16.copyWith(
                            color: theme.colorScheme.primary,
                          ),
                        ),
                        if (discount > 0) ...[
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.red[100],
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              '${discount.toInt()}% OFF',
                              style: TextStyles.bold13.copyWith(
                                color: Colors.red[700],
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                    
                    const SizedBox(height: 4),
                    
                    // Rating and stock status
                    Row(
                      children: [
                        if (rating > 0) ...[
                          Icon(
                            Icons.star,
                            size: 14,
                            color: Colors.amber[600],
                          ),
                          const SizedBox(width: 2),
                          Text(
                            rating.toStringAsFixed(1),
                            style: TextStyles.regular13.copyWith(
                              color: isDark ? Colors.grey[200] : Colors.grey[700],
                            ),
                          ),
                          if (reviewCount > 0) ...[
                            Text(
                              ' (${reviewCount})',
                              style: TextStyles.regular13.copyWith(
                                color: isDark ? Colors.grey[400] : Colors.grey[600],
                              ),
                            ),
                          ],
                          const SizedBox(width: 12),
                        ],
                        
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: inStock 
                                ? Colors.green[100] 
                                : Colors.red[100],
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            inStock ? 'In Stock' : 'Out of Stock',
                            style: TextStyles.bold13.copyWith(
                              color: inStock 
                                  ? Colors.green[700] 
                                  : Colors.red[700],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              
              // Arrow icon
              Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: isDark ? Colors.grey[600] : Colors.grey[400],
              ),
            ],
          ),
        ),
      ),
    );
  }
}