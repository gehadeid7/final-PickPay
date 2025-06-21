import 'package:flutter/material.dart';
import 'package:pickpay/core/utils/app_text_styles.dart';
import 'package:pickpay/core/services/ai_search_service.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/products_views/product_detail_view.dart';
import 'package:pickpay/services/api_service.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/gestures.dart';
import 'dart:async';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:permission_handler/permission_handler.dart';
import 'package:pickpay/features/categories_pages/products_views/electronics_products_views/product1.dart';
import 'package:pickpay/features/categories_pages/products_views/electronics_products_views/product2.dart';
import 'package:pickpay/features/categories_pages/products_views/electronics_products_views/product3.dart';
import 'package:pickpay/features/categories_pages/products_views/electronics_products_views/product4.dart';
import 'package:pickpay/features/categories_pages/products_views/electronics_products_views/product5.dart';
import 'package:pickpay/features/categories_pages/products_views/electronics_products_views/product6.dart';
import 'package:pickpay/features/categories_pages/products_views/electronics_products_views/product7.dart';
import 'package:pickpay/features/categories_pages/products_views/electronics_products_views/product8.dart';
import 'package:pickpay/features/categories_pages/products_views/electronics_products_views/product9.dart';
import 'package:pickpay/features/categories_pages/products_views/electronics_products_views/product10.dart';
import 'package:pickpay/features/categories_pages/products_views/electronics_products_views/product11.dart';
import 'package:pickpay/features/categories_pages/products_views/electronics_products_views/product12.dart';
import 'package:pickpay/features/categories_pages/products_views/electronics_products_views/product13.dart';
import 'package:pickpay/features/categories_pages/products_views/electronics_products_views/product14.dart';
import 'package:pickpay/features/categories_pages/products_views/electronics_products_views/product15.dart';
import 'package:pickpay/features/categories_pages/products_views/beauty_products_views/beauty_product1.dart';
import 'package:pickpay/features/categories_pages/products_views/beauty_products_views/beauty_product2.dart';
import 'package:pickpay/features/categories_pages/products_views/beauty_products_views/beauty_product3.dart';
import 'package:pickpay/features/categories_pages/products_views/beauty_products_views/beauty_product4.dart';
import 'package:pickpay/features/categories_pages/products_views/beauty_products_views/beauty_product5.dart';
import 'package:pickpay/features/categories_pages/products_views/beauty_products_views/beauty_product6.dart';
import 'package:pickpay/features/categories_pages/products_views/beauty_products_views/beauty_product7.dart';
import 'package:pickpay/features/categories_pages/products_views/beauty_products_views/beauty_product8.dart';
import 'package:pickpay/features/categories_pages/products_views/beauty_products_views/beauty_product9.dart';
import 'package:pickpay/features/categories_pages/products_views/beauty_products_views/beauty_product10.dart';
import 'package:pickpay/features/categories_pages/products_views/beauty_products_views/beauty_product11.dart';
import 'package:pickpay/features/categories_pages/products_views/beauty_products_views/beauty_product12.dart';
import 'package:pickpay/features/categories_pages/products_views/beauty_products_views/beauty_product13.dart';
import 'package:pickpay/features/categories_pages/products_views/beauty_products_views/beauty_product14.dart';
import 'package:pickpay/features/categories_pages/products_views/beauty_products_views/beauty_product15.dart';
import 'package:pickpay/features/categories_pages/products_views/beauty_products_views/beauty_product16.dart';
import 'package:pickpay/features/categories_pages/products_views/beauty_products_views/beauty_product17.dart';
import 'package:pickpay/features/categories_pages/products_views/beauty_products_views/beauty_product18.dart';
import 'package:pickpay/features/categories_pages/products_views/beauty_products_views/beauty_product19.dart';
import 'package:pickpay/features/categories_pages/products_views/beauty_products_views/beauty_product20.dart';
import 'package:pickpay/features/categories_pages/products_views/fashion_products_views/fashion_product1.dart';
import 'package:pickpay/features/categories_pages/products_views/fashion_products_views/fashion_product2.dart';
import 'package:pickpay/features/categories_pages/products_views/fashion_products_views/fashion_product3.dart';
import 'package:pickpay/features/categories_pages/products_views/fashion_products_views/fashion_product4.dart';
import 'package:pickpay/features/categories_pages/products_views/fashion_products_views/fashion_product5.dart';
import 'package:pickpay/features/categories_pages/products_views/fashion_products_views/fashion_product6.dart';
import 'package:pickpay/features/categories_pages/products_views/fashion_products_views/fashion_product7.dart';
import 'package:pickpay/features/categories_pages/products_views/fashion_products_views/fashion_product8.dart';
import 'package:pickpay/features/categories_pages/products_views/fashion_products_views/fashion_product9.dart';
import 'package:pickpay/features/categories_pages/products_views/fashion_products_views/fashion_product10.dart';
import 'package:pickpay/features/categories_pages/products_views/fashion_products_views/fashion_product11.dart';
import 'package:pickpay/features/categories_pages/products_views/fashion_products_views/fashion_product12.dart';
import 'package:pickpay/features/categories_pages/products_views/fashion_products_views/fashion_product13.dart';
import 'package:pickpay/features/categories_pages/products_views/fashion_products_views/fashion_product14.dart';
import 'package:pickpay/features/categories_pages/products_views/fashion_products_views/fashion_product15.dart';
import 'package:pickpay/features/categories_pages/products_views/home_products/home_product1.dart';
import 'package:pickpay/features/categories_pages/products_views/home_products/home_product2.dart';
import 'package:pickpay/features/categories_pages/products_views/home_products/home_product3.dart';
import 'package:pickpay/features/categories_pages/products_views/home_products/home_product4.dart';
import 'package:pickpay/features/categories_pages/products_views/home_products/home_product5.dart';
import 'package:pickpay/features/categories_pages/products_views/home_products/home_product6.dart';
import 'package:pickpay/features/categories_pages/products_views/home_products/home_product7.dart';
import 'package:pickpay/features/categories_pages/products_views/home_products/home_product8.dart';
import 'package:pickpay/features/categories_pages/products_views/home_products/home_product9.dart';
import 'package:pickpay/features/categories_pages/products_views/home_products/home_product10.dart';
import 'package:pickpay/features/categories_pages/products_views/home_products/home_product11.dart';
import 'package:pickpay/features/categories_pages/products_views/home_products/home_product12.dart';
import 'package:pickpay/features/categories_pages/products_views/home_products/home_product13.dart';
import 'package:pickpay/features/categories_pages/products_views/home_products/home_product14.dart';
import 'package:pickpay/features/categories_pages/products_views/home_products/home_product15.dart';
import 'package:pickpay/features/categories_pages/products_views/home_products/home_product16.dart';
import 'package:pickpay/features/categories_pages/products_views/home_products/home_product17.dart';
import 'package:pickpay/features/categories_pages/products_views/home_products/home_product18.dart';
import 'package:pickpay/features/categories_pages/products_views/home_products/home_product19.dart';
import 'package:pickpay/features/categories_pages/products_views/home_products/home_product20.dart';
import 'package:pickpay/features/categories_pages/products_views/appliances_products_views/appliances_product1.dart';
import 'package:pickpay/features/categories_pages/products_views/appliances_products_views/appliances_product2.dart';
import 'package:pickpay/features/categories_pages/products_views/appliances_products_views/appliances_product3.dart';
import 'package:pickpay/features/categories_pages/products_views/appliances_products_views/appliances_product4.dart';
import 'package:pickpay/features/categories_pages/products_views/appliances_products_views/appliances_product5.dart';
import 'package:pickpay/features/categories_pages/products_views/appliances_products_views/appliances_product6.dart';
import 'package:pickpay/features/categories_pages/products_views/appliances_products_views/appliances_product7.dart';
import 'package:pickpay/features/categories_pages/products_views/appliances_products_views/appliances_product8.dart';
import 'package:pickpay/features/categories_pages/products_views/appliances_products_views/appliances_product9.dart';
import 'package:pickpay/features/categories_pages/products_views/appliances_products_views/appliances_product10.dart';
import 'package:pickpay/features/categories_pages/products_views/appliances_products_views/appliances_product11.dart';
import 'package:pickpay/features/categories_pages/products_views/appliances_products_views/appliances_product12.dart';
import 'package:pickpay/features/categories_pages/products_views/appliances_products_views/appliances_product13.dart';
import 'package:pickpay/features/categories_pages/products_views/appliances_products_views/appliances_product14.dart';
import 'package:pickpay/features/categories_pages/products_views/appliances_products_views/appliances_product15.dart';
import 'package:pickpay/features/categories_pages/products_views/video_games/video_games_product1.dart';
import 'package:pickpay/features/categories_pages/products_views/video_games/video_games_product2.dart';
import 'package:pickpay/features/categories_pages/products_views/video_games/video_games_product3.dart';
import 'package:pickpay/features/categories_pages/products_views/video_games/video_games_product4.dart';
import 'package:pickpay/features/categories_pages/products_views/video_games/video_games_product5.dart';
import 'package:pickpay/features/categories_pages/products_views/video_games/video_games_product6.dart';
import 'package:pickpay/features/categories_pages/products_views/video_games/video_games_product7.dart';
import 'package:pickpay/features/categories_pages/products_views/video_games/video_games_product8.dart';
import 'package:pickpay/features/categories_pages/products_views/video_games/video_games_product9.dart';
import 'package:pickpay/features/categories_pages/products_views/video_games/video_games_product10.dart';
import 'package:pickpay/features/categories_pages/products_views/video_games/video_games_product11.dart';
import 'package:pickpay/features/categories_pages/products_views/video_games/video_games_product12.dart';
import 'package:pickpay/features/categories_pages/products_views/video_games/video_games_product13.dart';
import 'package:pickpay/features/categories_pages/products_views/video_games/video_games_product14.dart';
import 'package:shimmer/shimmer.dart';

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

  // Updated popular searches
  final List<String> _popularSearches = [
    'Samsung Galaxy Tab', // Electronics
    'Koldair Water Dispenser Cold', // Appliances
    'Golden Life Sofa Bed', // Home
    'L\'Oréal Paris Mascara', // Beauty
    'Sony PlayStation 5', // Video Games
  ];

  // Removed unused fields
  // final List<String> _categories = [ ... ];
  // String? _selectedCategory;
  // List<String> _filters = [];

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

  // Add dummy usage to ensure the import is used
  final _dummyGestureRecognizer = TapGestureRecognizer();

  // 1. Add new fields for spelling correction, filters, sorting, and trending/favorite searches
  List<String> _didYouMean = [];
  List<String> _trendingSearches = [];
  List<String> _favoriteSearches = [];
  String _selectedSort = 'Price: Low to High';
  List<String> _sortOptions = ['Price: Low to High', 'Price: High to Low', 'Rating'];
  List<String> _activeFilters = [];
  List<String> _availableFilters = ['Electronics', 'Beauty', 'Fashion', 'Home', 'Appliances', 'Video Games']; // Example categories

  // 1. Add state for error and skeleton loading
  bool _hasError = false;
  String _errorMessage = '';

  // 1. Add advanced filter state
  bool _showAdvancedFilters = false;
  RangeValues _priceRange = const RangeValues(0, 1000);
  double _minRating = 0;
  String? _selectedBrand;

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

  // Remove a single recent search item
  Future<void> _removeRecentSearch(String query) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      setState(() {
        _recentSearches.remove(query);
      });
      await prefs.setStringList(_recentSearchesKey, _recentSearches);
    } catch (e) {
      print('❌ Error removing recent search: $e');
      _showSnackBar('Failed to remove search history item', isError: true);
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

    // --- Static View Navigation ---
    Widget? staticProductView;
    switch (productId) {
      // Electronics Products
      case '6819e22b123a4faad16613be':
        staticProductView = const Product1View();
        break;
      case '6819e22b123a4faad16613bf':
        staticProductView = const Product2View();
        break;
      case '6819e22b123a4faad16613c0':
        staticProductView = const Product3View();
        break;
      case '6819e22b123a4faad16613c1':
        staticProductView = const Product4View();
        break;
      case '6819e22b123a4faad16613c3':
        staticProductView = const Product5View();
        break;
      case '6819e22b123a4faad16613c4':
        staticProductView = const Product6View();
        break;
      case '6819e22b123a4faad16613c5':
        staticProductView = const Product7View();
        break;
      case '6819e22b123a4faad16613c6':
        staticProductView = const Product8View();
        break;
      case '6819e22b123a4faad16613c7':
        staticProductView = const Product9View();
        break;
      case '6819e22b123a4faad16613c8':
        staticProductView = const Product10View();
        break;
      case '6819e22b123a4faad16613c9':
        staticProductView = const Product11View();
        break;
      case '6819e22b123a4faad16613ca':
        staticProductView = const Product12View();
        break;
      case '6819e22b123a4faad16613cb':
        staticProductView = const Product13View();
        break;
      case '6819e22b123a4faad16613cc':
        staticProductView = const Product14View();
        break;
      case '6819e22b123a4faad16613c2':
        staticProductView = const Product15View();
        break;
      // Beauty Products
      case '682b00d16977bd89257c0e9d':
        staticProductView = const BeautyProduct1();
        break;
      case '682b00d16977bd89257c0e9e':
        staticProductView = const BeautyProduct2();
        break;
      case '682b00d16977bd89257c0e9f':
        staticProductView = const BeautyProduct3();
        break;
      case '682b00d16977bd89257c0ea0':
        staticProductView = const BeautyProduct4();
        break;
      case '682b00d16977bd89257c0ea1':
        staticProductView = const BeautyProduct5();
        break;
      case '682b00d16977bd89257c0ea2':
        staticProductView = const BeautyProduct6();
        break;
      case '682b00d16977bd89257c0ea3':
        staticProductView = const BeautyProduct7();
        break;
      case '682b00d16977bd89257c0ea4':
        staticProductView = const BeautyProduct8();
        break;
      case '682b00d16977bd89257c0ea5':
        staticProductView = const BeautyProduct9();
        break;
      case '682b00d16977bd89257c0ea6':
        staticProductView = const BeautyProduct10();
        break;
      case '682b00d16977bd89257c0ea7':
        staticProductView = const BeautyProduct11();
        break;
      case '682b00d16977bd89257c0ea8':
        staticProductView = const BeautyProduct12();
        break;
      case '682b00d16977bd89257c0ea9':
        staticProductView = const BeautyProduct13();
        break;
      case '682b00d16977bd89257c0eaa':
        staticProductView = const BeautyProduct14();
        break;
      case '682b00d16977bd89257c0eab':
        staticProductView = const BeautyProduct15();
        break;
      case '682b00d16977bd89257c0eac':
        staticProductView = const BeautyProduct16();
        break;
      case '682b00d16977bd89257c0ead':
        staticProductView = const BeautyProduct17();
        break;
      case '682b00d16977bd89257c0eae':
        staticProductView = const BeautyProduct18();
        break;
      case '682b00d16977bd89257c0eaf':
        staticProductView = const BeautyProduct19();
        break;
      case '682b00d16977bd89257c0eb0':
        staticProductView = const BeautyProduct20();
        break;
      // Fashion Products
      case '682b00c26977bd89257c0e8e':
        staticProductView = const FashionProduct1();
        break;
      case '682b00c26977bd89257c0e8f':
        staticProductView = const FashionProduct2();
        break;
      case '682b00c26977bd89257c0e90':
        staticProductView = const FashionProduct3();
        break;
      case '682b00c26977bd89257c0e91':
        staticProductView = const FashionProduct4();
        break;
      case '682b00c26977bd89257c0e92':
        staticProductView = const FashionProduct5();
        break;
      case '682b00c26977bd89257c0e93':
        staticProductView = const FashionProduct6();
        break;
      case '682b00c26977bd89257c0e94':
        staticProductView = const FashionProduct7();
        break;
      case '682b00c26977bd89257c0e95':
        staticProductView = const FashionProduct8();
        break;
      case '682b00c26977bd89257c0e96':
        staticProductView = const FashionProduct9();
        break;
      case '682b00c26977bd89257c0e97':
        staticProductView = const FashionProduct10();
        break;
      case '682b00c26977bd89257c0e98':
        staticProductView = const FashionProduct11();
        break;
      case '682b00c26977bd89257c0e99':
        staticProductView = const FashionProduct12();
        break;
      case '682b00c26977bd89257c0e9a':
        staticProductView = const FashionProduct13();
        break;
      case '682b00c26977bd89257c0e9b':
        staticProductView = const FashionProduct14();
        break;
      case '682b00c26977bd89257c0e9c':
        staticProductView = const FashionProduct15();
        break;
      // Home Products
      case '681dab0df9c9147444b452cd':
        staticProductView = const HomeProduct1();
        break;
      case '681dab0df9c9147444b452ce':
        staticProductView = const HomeProduct2();
        break;
      case '681dab0df9c9147444b452cf':
        staticProductView = const HomeProduct3();
        break;
      case '681dab0df9c9147444b452d0':
        staticProductView = const HomeProduct4();
        break;
      case '681dab0df9c9147444b452d1':
        staticProductView = const HomeProduct5();
        break;
      case '681dab0df9c9147444b452d2':
        staticProductView = const HomeProduct6();
        break;
      case '681dab0df9c9147444b452d3':
        staticProductView = const HomeProduct7();
        break;
      case '681dab0df9c9147444b452d4':
        staticProductView = const HomeProduct8();
        break;
      case '681dab0df9c9147444b452d5':
        staticProductView = const HomeProduct9();
        break;
      case '681dab0df9c9147444b452d6':
        staticProductView = const HomeProduct10();
        break;
      case '681dab0df9c9147444b452d7':
        staticProductView = const HomeProduct11();
        break;
      case '681dab0df9c9147444b452d8':
        staticProductView = const HomeProduct12();
        break;
      case '681dab0df9c9147444b452d9':
        staticProductView = const HomeProduct13();
        break;
      case '681dab0df9c9147444b452da':
        staticProductView = const HomeProduct14();
        break;
      case '681dab0df9c9147444b452db':
        staticProductView = const HomeProduct15();
        break;
      case '681dab0df9c9147444b452dc':
        staticProductView = const HomeProduct16();
        break;
      case '681dab0df9c9147444b452dd':
        staticProductView = const HomeProduct17();
        break;
      case '681dab0df9c9147444b452de':
        staticProductView = const HomeProduct18();
        break;
      case '681dab0df9c9147444b452df':
        staticProductView = const HomeProduct19();
        break;
      case '681dab0df9c9147444b452e0':
        staticProductView = const HomeProduct20();
        break;
      // Appliances Products
      case '68252918a68b49cb06164204':
        staticProductView = const AppliancesProduct1();
        break;
      case '68252918a68b49cb06164205':
        staticProductView = const AppliancesProduct2();
        break;
      case '68252918a68b49cb06164206':
        staticProductView = const AppliancesProduct3();
        break;
      case '68252918a68b49cb06164207':
        staticProductView = const AppliancesProduct4();
        break;
      case '68252918a68b49cb06164208':
        staticProductView = const AppliancesProduct5();
        break;
      case '68252918a68b49cb06164209':
        staticProductView = const AppliancesProduct6();
        break;
      case '68252918a68b49cb0616420a':
        staticProductView = const AppliancesProduct7();
        break;
      case '68252918a68b49cb0616420b':
        staticProductView = const AppliancesProduct8();
        break;
      case '68252918a68b49cb0616420c':
        staticProductView = const AppliancesProduct9();
        break;
      case '68252918a68b49cb0616420d':
        staticProductView = const AppliancesProduct10();
        break;
      case '68252918a68b49cb0616420e':
        staticProductView = const AppliancesProduct11();
        break;
      case '68252918a68b49cb0616420f':
        staticProductView = const AppliancesProduct12();
        break;
      case '68252918a68b49cb06164210':
        staticProductView = const AppliancesProduct13();
        break;
      case '68252918a68b49cb06164211':
        staticProductView = const AppliancesProduct14();
        break;
      case '68252918a68b49cb06164212':
        staticProductView = const AppliancesProduct15();
        break;
      // Video Games Products
      case '682b00a46977bd89257c0e80':
        staticProductView = const VideoGamesProduct1();
        break;
      case '682b00a46977bd89257c0e81':
        staticProductView = const VideoGamesProduct2();
        break;
      case '682b00a46977bd89257c0e82':
        staticProductView = const VideoGamesProduct3();
        break;
      case '682b00a46977bd89257c0e83':
        staticProductView = const VideoGamesProduct4();
        break;
      case '682b00a46977bd89257c0e84':
        staticProductView = const VideoGamesProduct5();
        break;
      case '682b00a46977bd89257c0e85':
        staticProductView = const VideoGamesProduct6();
        break;
      case '682b00a46977bd89257c0e86':
        staticProductView = const VideoGamesProduct7();
        break;
      case '682b00a46977bd89257c0e87':
        staticProductView = const VideoGamesProduct8();
        break;
      case '682b00a46977bd89257c0e88':
        staticProductView = const VideoGamesProduct9();
        break;
      case '682b00a46977bd89257c0e89':
        staticProductView = const VideoGamesProduct10();
        break;
      case '682b00a46977bd89257c0e8a':
        staticProductView = const VideoGamesProduct11();
        break;
      case '682b00a46977bd89257c0e8b':
        staticProductView = const VideoGamesProduct12();
        break;
      case '682b00a46977bd89257c0e8c':
        staticProductView = const VideoGamesProduct13();
        break;
      case '682b00a46977bd89257c0e8d':
        staticProductView = const VideoGamesProduct14();
        break;
    }
    if (staticProductView != null) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => staticProductView!),
      );
      setState(() => _showDropdown = false);
      _focusNode.unfocus();
      return;
    }
    setState(() => _isProductLoading = true);

    try {
      final api = ApiService();
      final fullProductJson = await api.getProductById(productId);

      if (fullProductJson != null && mounted) {
        final fullProduct = ProductsViewsModel.fromJson(fullProductJson);
        Navigator.pushNamed(context, ProductDetailView.routeName,
            arguments: fullProduct);
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
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );
    }
  }

  // 2. Add analytics hooks (as comments)
  void _logSearchEvent(String query) {
    // TODO: Integrate analytics: log search event
    // Example: AnalyticsService.logSearch(query);
  }
  void _logClickEvent(String type, String value) {
    // TODO: Integrate analytics: log click event (type: suggestion, product, etc.)
    // Example: AnalyticsService.logClick(type, value);
  }
  void _logErrorEvent(String error) {
    // TODO: Integrate analytics: log error event
    // Example: AnalyticsService.logError(error);
  }

  // 3. Update _searchProducts to handle error and log events
  Future<void> _searchProducts(String query, {bool fromSuggestion = false}) async {
    final trimmedQuery = query.trim();
    if (trimmedQuery.isEmpty) {
      _clearSearchState();
      return;
    }
    if (trimmedQuery == _lastSearchQuery && !fromSuggestion) {
      return;
    }
    _lastSearchQuery = trimmedQuery;
    _debounce?.cancel();
    if (!_isLoading) {
      setState(() {
        _isLoading = true;
        _showDropdown = true;
        _hasError = false;
        _errorMessage = '';
      });
    }
    _debounce = Timer(_debounceDelay, () async {
      if (!mounted) return;
      try {
        await _addRecentSearch(trimmedQuery);
        await _fetchDidYouMean(trimmedQuery);
        await _fetchTrendingAndFavorites();
        _logSearchEvent(trimmedQuery);
        // ... existing code ...
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
        _logErrorEvent(e.toString());
        if (mounted) {
          setState(() {
            _isLoading = false;
            _hasError = true;
            _errorMessage = 'Search failed. Please check your connection.';
          });
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

  List<Map<String, dynamic>> _processSearchResults(
      List<Map<String, dynamic>> results) {
    return results
        .map((result) {
          // Ensure all required fields are present with fallbacks
          return {
            'id': result['id'] ?? result['_id'] ?? result['productId'] ?? '',
            'title': result['title'] ??
                result['name'] ??
                result['productName'] ??
                'Unknown Product',
            'price': _parsePrice(result['price']),
            'images': _parseImages(result['images'] ??
                result['imagePaths'] ??
                result['imageUrls']),
            'brand': result['brand'] ?? result['manufacturer'] ?? '',
            'category': result['category'] ?? result['categoryName'] ?? '',
            'description': result['description'] ??
                result['aboutThisItem'] ??
                result['summary'] ??
                '',
            'rating':
                _parseRating(result['rating'] ?? result['ratingsAverage']),
            'reviewCount': _parseReviewCount(
                result['reviewCount'] ?? result['ratingsQuantity']),
            'inStock': result['inStock'] ?? result['stock'] ?? true,
            'discount': _parseDiscount(
                result['discount'] ?? result['discountPercentage']),
          };
        })
        .where((item) => item['title'] != 'Unknown Product')
        .toList();
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
    if (images is List)
      return images
          .map((img) => img.toString())
          .where((img) => img.isNotEmpty)
          .toList();
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
    if (_recentSearches.isNotEmpty &&
        widget.controller.text.isEmpty &&
        _isFocused) {
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
    if (_recentSearches.isNotEmpty &&
        widget.controller.text.isEmpty &&
        _isFocused) {
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

  // In your search_text_field.dart file, update the _listenVoice method:

  Future<void> _listenVoice() async {
    if (!_speechAvailable) {
      _showSnackBar('Voice search is not available on this device',
          isError: true);
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
          onResult: (result) async {
            setState(() {
              _voiceInput = result.recognizedWords;
              widget.controller.text = _voiceInput;
            });

            if (result.finalResult && _voiceInput.isNotEmpty) {
              setState(() => _isListening = false);

              // Send voice input to backend for processing
              await _processVoiceSearch(_voiceInput);
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

  // Add this new method to process voice search through backend
  Future<void> _processVoiceSearch(String voiceText) async {
    if (voiceText.trim().isEmpty) return;

    setState(() {
      _isLoading = true;
      _showDropdown = true;
    });

    try {
      final api = ApiService();

      // Call the voice search API endpoint
      final voiceSearchResults = await api.processVoiceSearch(voiceText);
      if (voiceSearchResults.isNotEmpty) {
        // Process the backend results
        final processedResults = _processVoiceSearchResults(voiceSearchResults);

        if (mounted) {
          setState(() {
            _searchResults = processedResults;
            _isLoading = false;
          });

          // Update the search field with the processed text if available
          if (processedResults.isNotEmpty) {
            // You might want to extract keywords from the results for the search field
            final firstResult = processedResults.first;
            final keywords = _extractKeywords(firstResult['title'] ?? '');
            if (keywords.isNotEmpty) {
              widget.controller.text = keywords;
            }
          }
        }
      } else {
        // Fallback to regular search if backend doesn't return results
        _searchProducts(voiceText);
      }
    } catch (e) {
      print('❌ Voice search processing error: $e');
      // Fallback to regular search on error
      _searchProducts(voiceText);
    }
  }

  // Helper method to process voice search results from backend
  List<Map<String, dynamic>> _processVoiceSearchResults(List<dynamic> results) {
    return results.map((result) {
      if (result is Map<String, dynamic>) {
        return {
          'id': result['slug'] ?? result['id'] ?? '',
          'title': result['title'] ?? 'Unknown Product',
          'price': _parsePrice(result['price']),
          'images': result['imageUrls'] ?? result['images'] ?? [],
          'brand': result['brand'] ?? '',
          'category': result['category'] ?? '',
          'description': result['description'] ?? '',
          'rating': _parseRating(result['rating']),
          'reviewCount': _parseReviewCount(result['reviewCount']),
          'inStock': result['inStock'] ?? true,
          'discount': _parseDiscount(result['discount']),
          'pageUrl': result['pageUrl'] ?? '',
          'slug': result['slug'] ?? '',
        };
      } else if (result is String) {
        return {
          'id': '',
          'title': result,
          'price': null,
          'images': [],
          'brand': '',
          'category': '',
          'description': '',
          'rating': null,
          'reviewCount': null,
          'inStock': true,
          'discount': null,
          'pageUrl': '',
          'slug': '',
        };
      } else {
        return {
          'id': '',
          'title': 'Unknown',
          'images': [],
        };
      }
    }).toList();
  }

  // Helper method to extract keywords from product title
  String _extractKeywords(String title) {
    if (title.isEmpty) return '';

    // Simple keyword extraction - take first few meaningful words
    final words = title.split(' ');
    final meaningfulWords = words
        .where((word) => word.length > 2 && !_isStopWord(word.toLowerCase()))
        .take(3)
        .join(' ');

    return meaningfulWords;
  }

  // Helper method to identify stop words
  bool _isStopWord(String word) {
    const stopWords = {'the', 'and', 'for', 'with', 'pro', 'max', 'mini'};
    return stopWords.contains(word);
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
            color: _isListening
                ? Colors.red
                : (_speechAvailable ? Colors.blue[600] : Colors.grey),
            size: _isListening ? 24 : 22,
          ),
          onPressed: _speechAvailable ? _listenVoice : null,
          tooltip:
              _speechAvailable ? 'Voice Search' : 'Voice search unavailable',
          splashRadius: 24,
        ),
      ),
    );
  }

  // 2. Add a method to fetch spelling corrections and trending/favorite searches (simulate for now)
  Future<void> _fetchDidYouMean(String query) async {
    // Simulate spelling correction (replace with backend call)
    if (query.toLowerCase() == 'iphon') {
      setState(() => _didYouMean = ['iPhone', 'iPhone 14', 'iPhone 13']);
    } else {
      setState(() => _didYouMean = []);
    }
  }
  Future<void> _fetchTrendingAndFavorites() async {
    // Simulate trending/favorite searches (replace with backend call)
    setState(() {
      _trendingSearches = ['PlayStation 5', 'AirPods Pro', 'Dyson Vacuum'];
      _favoriteSearches = ['Samsung Galaxy Tab', 'Golden Life Sofa Bed'];
    });
  }

  // 4. Add filter chip and sort dropdown widgets
  Widget _buildFilterChips() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: _availableFilters.map((filter) {
          final isActive = _activeFilters.contains(filter);
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: FilterChip(
              label: Text(filter),
              selected: isActive,
              onSelected: (selected) {
                setState(() {
                  if (selected) {
                    _activeFilters.add(filter);
                  } else {
                    _activeFilters.remove(filter);
                  }
                });
                // Optionally, trigger a filtered search
              },
            ),
          );
        }).toList(),
      ),
    );
  }
  Widget _buildSortDropdown() {
    if (_sortOptions.isEmpty) return SizedBox.shrink();
    return DropdownButton<String>(
      value: _selectedSort,
      items: _sortOptions.map((option) {
        return DropdownMenuItem<String>(
          value: option,
          child: Text(option),
        );
      }).toList(),
      onChanged: (value) {
        if (value != null) {
          setState(() => _selectedSort = value);
          // Optionally, trigger a sorted search
        }
      },
      underline: SizedBox(),
      style: TextStyle(fontSize: 14, color: Colors.grey[800]),
      icon: Icon(Icons.sort, size: 18, color: Colors.grey[600]),
    );
  }

  // 5. Modularize dropdown content: extract sections as widgets
  Widget _buildDidYouMeanSection() {
    if (_didYouMean.isEmpty) return SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader('Did you mean?', icon: Icons.spellcheck),
        ..._didYouMean.map((suggestion) => _buildListItem(
              leading: Icon(Icons.spellcheck, color: Colors.orange[400], size: 20),
              title: suggestion,
              onTap: () {
                widget.controller.text = suggestion;
                _searchProducts(suggestion, fromSuggestion: true);
              },
            )),
        const Divider(height: 1),
      ],
    );
  }
  Widget _buildTrendingSection() {
    if (_trendingSearches.isEmpty) return SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader('Trending', icon: Icons.trending_up),
        ..._trendingSearches.map((search) => _buildListItem(
              leading: Icon(Icons.trending_up, color: Colors.purple[400], size: 20),
              title: search,
              onTap: () {
                widget.controller.text = search;
                _searchProducts(search);
              },
            )),
        const Divider(height: 1),
      ],
    );
  }

  // 6. Update _buildDropdownContent to include new sections and controls
  Widget _buildDropdownContent(
      bool isDark, Color primaryColor, Color? surfaceColor, Color textColor) {
    final showRecent = _isFocused &&
        widget.controller.text.isEmpty &&
        _recentSearches.isNotEmpty;
    if (_isLoading) {
      return _buildSkeletonLoader();
    }
    if (_hasError) {
      return _buildErrorWidget();
    }
    if (!showRecent &&
        _suggestions.isEmpty &&
        _searchResults.isEmpty &&
        !_isLoading) {
      if (widget.controller.text.isNotEmpty) {
        return _buildNoResultsWidget(textColor);
      }
      return _buildPopularSearches(primaryColor, textColor);
    }
    return Container(
      constraints: BoxConstraints(
        maxHeight: (_suggestions.isNotEmpty || _searchResults.isNotEmpty || showRecent)
            ? 500
            : double.infinity,
      ),
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
                // New: Did you mean section
                _buildDidYouMeanSection(),
                // New: Trending (Favorites section removed)
                _buildTrendingSection(),
                // ... existing code for recent, suggestions, results, loading ...
                if (showRecent) ...[
                  _buildSectionHeader(
                    'Recent Searches',
                    icon: Icons.history,
                    action: IconButton(
                      icon: Icon(Icons.clear_all,
                          size: 18, color: Colors.grey[600]),
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
                      leading: Icon(Icons.history,
                          color: Colors.grey[500], size: 20),
                      title: search,
                      onTap: () {
                        widget.controller.text = search;
                        _searchProducts(search);
                      },
                      isHighlighted: _highlightedIndex == globalIndex,
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.north_west,
                                size: 16, color: Colors.grey[500]),
                            onPressed: () => widget.controller.text = search,
                            splashRadius: 12,
                            tooltip: 'Fill search',
                          ),
                          IconButton(
                            icon: Icon(Icons.delete_outline,
                                size: 18, color: Colors.red[400]),
                            onPressed: () => _removeRecentSearch(search),
                            splashRadius: 14,
                            tooltip: 'Remove from history',
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                  const Divider(height: 1),
                ],
                if (_suggestions.isNotEmpty) ...[
                  _buildSectionHeader('Suggestions', icon: Icons.auto_awesome),
                  ..._suggestions.asMap().entries.map((entry) {
                    final index = entry.key;
                    final suggestion = entry.value;
                    final globalIndex =
                        (showRecent ? _recentSearches.length : 0) + index;
                    // Instead of just searching, navigate to product page directly
                    return _buildListItem(
                      leading:
                          Icon(Icons.search, color: Colors.blue[400], size: 20),
                      title: suggestion,
                      subtitle: 'Search suggestion',
                      onTap: () {
                        // Try to find a product in _searchResults that matches the suggestion
                        final matchedProduct = _searchResults.firstWhere(
                          (product) => (product['title'] ?? '').toLowerCase() == suggestion.toLowerCase(),
                          orElse: () => <String, dynamic>{},
                        );
                        if (matchedProduct.isNotEmpty) {
                          _handleProductSelection(matchedProduct);
                        } else {
                          // If not found, fallback to search and then try to navigate after results load
                          widget.controller.text = suggestion;
                          _searchProducts(suggestion, fromSuggestion: true);
                        }
                      },
                      isHighlighted: _highlightedIndex == globalIndex,
                      trailing: IconButton(
                        icon: Icon(Icons.north_west,
                            size: 16, color: Colors.grey[500]),
                        onPressed: () => widget.controller.text = suggestion,
                        splashRadius: 12,
                        tooltip: 'Fill search',
                      ),
                    );
                  }).toList(),
                  if (_searchResults.isNotEmpty) const Divider(height: 1),
                ],
                if (_searchResults.isNotEmpty) ...[
                  _buildSectionHeader('Products', icon: Icons.shopping_bag),
                  ..._searchResults.asMap().entries.map((entry) {
                    final index = entry.key;
                    final product = entry.value;
                    final globalIndex =
                        (showRecent ? _recentSearches.length : 0) +
                            _suggestions.length +
                            index;
                    return _buildProductItem(
                      product: product,
                      query: widget.controller.text,
                      isHighlighted: _highlightedIndex == globalIndex,
                    );
                  }).toList(),
                ],
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
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(primaryColor),
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
                // 3. Add advanced filter section
                if (_showAdvancedFilters)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Price Range
                        Container(
                          width: double.infinity,
                          child: Row(
                            children: [
                              Text('Price Range: ', style: TextStyles.regular13),
                              Expanded(
                                child: RangeSlider(
                                  values: _priceRange,
                                  min: 0,
                                  max: 1000,
                                  divisions: 20,
                                  labels: RangeLabels(
                                    '${_priceRange.start.round()}',
                                    '${_priceRange.end.round()}',
                                  ),
                                  onChanged: (values) {
                                    setState(() => _priceRange = values);
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Minimum Rating
                        Container(
                          width: double.infinity,
                          child: Row(
                            children: [
                              Text('Min Rating: \\${_minRating.toStringAsFixed(1)}', style: TextStyles.regular13),
                              Expanded(
                                child: Slider(
                                  value: _minRating,
                                  min: 0,
                                  max: 5,
                                  divisions: 10,
                                  label: _minRating.toStringAsFixed(1),
                                  onChanged: (value) {
                                    setState(() => _minRating = value);
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Brand Dropdown
                        DropdownButton<String>(
                          value: _selectedBrand,
                          hint: const Text('Select Brand'),
                          isExpanded: true,
                          items: [
                            const DropdownMenuItem(
                              value: null,
                              child: Text('All Brands'),
                            ),
                            ..._searchResults
                                .map((product) => product['brand'] as String?)
                                .where((brand) => brand != null && brand.isNotEmpty)
                                .toSet()
                                .map((brand) => DropdownMenuItem(
                                      value: brand,
                                      child: Text(brand!),
                                    )),
                          ],
                          onChanged: (value) {
                            setState(() => _selectedBrand = value);
                          },
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // 5. Add skeleton loader and retry for loading/error states
  Widget _buildSkeletonLoader() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(3, (index) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 14,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        width: 120 + (index * 20),
                        height: 12,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Container(
                            width: 60,
                            height: 10,
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Container(
                            width: 40,
                            height: 10,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )),
        ),
      ),
    );
  }
  Widget _buildErrorWidget() {
    return Container(
      padding: const EdgeInsets.all(32),
      child: Column(
        children: [
          Icon(Icons.error_outline, size: 48, color: Colors.red[400]),
          const SizedBox(height: 16),
          Text(
            _errorMessage,
            style: TextStyles.bold16.copyWith(color: Colors.red[700]),
          ),
          const SizedBox(height: 8),
          ElevatedButton.icon(
            icon: Icon(Icons.refresh),
            label: Text('Retry'),
            onPressed: () {
              _searchProducts(widget.controller.text);
            },
          ),
        ],
      ),
    );
  }

  // 7. Accessibility: Add ARIA labels, screen reader support, and improved keyboard navigation
  // Example: Add semantics to main widgets
  // In build(), wrap main Column with Semantics
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final primaryColor = theme.colorScheme.primary;
    final surfaceColor = isDark ? Colors.grey[850] : Colors.white;
    final borderColor = isDark ? Colors.grey[600] : Colors.grey[300];
    final textColor = isDark ? Colors.white : Colors.black87;

    return Semantics(
      label: 'Search bar with suggestions and results',
      child: RawKeyboardListener(
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
                                  valueColor:
                                      AlwaysStoppedAnimation<Color>(primaryColor),
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
                      style:
                          TextStyles.regular13.copyWith(color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),

            // Dropdown Results
            if (_showDropdown && !_isProductLoading)
              Container(
                constraints: BoxConstraints(
                  maxHeight: 500, // Ensures bounded height for dropdown
                  minWidth: double.infinity,
                ),
                child: SlideTransition(
                  position: _slideAnimation,
                  child: FadeTransition(
                    opacity: _opacityAnimation,
                    child: _buildDropdownContent(
                        isDark, primaryColor, surfaceColor, textColor),
                  ),
                ),
              ),
          ],
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
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Listening...',
                  style: TextStyles.medium15.copyWith(color: Colors.red[700]),
                ),
                if (_voiceInput.isNotEmpty)
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: TextEditingController(text: _voiceInput),
                          onChanged: (val) {
                            setState(() => _voiceInput = val);
                          },
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Edit voice input',
                          ),
                          style: TextStyles.regular13,
                          autofocus: false,
                          // Accessibility
                          textInputAction: TextInputAction.done,
                          enableSuggestions: true,
                          autocorrect: true,
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.search, color: Colors.blue[600]),
                        onPressed: () {
                          widget.controller.text = _voiceInput;
                          _searchProducts(_voiceInput);
                          setState(() => _isListening = false);
                        },
                        tooltip: 'Search with voice input',
                      ),
                    ],
                  ),
              ],
            ),
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
          mainAxisSize: MainAxisSize.min, // Shrink-wrap content
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader('Popular Searches', icon: Icons.trending_up),
            ..._popularSearches
                .take(6)
                .map((search) => _buildListItem(
                      leading: Icon(Icons.trending_up,
                          color: primaryColor, size: 20),
                      title: search,
                      onTap: () {
                        widget.controller.text = search;
                        _searchProducts(search);
                      },
                    ))
                .toList(),
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
          child: Container(
            width: double.infinity,
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
    final images = (product['images'] as List<dynamic>?)?.cast<String>() ?? [];
    final brand = product['brand'] ?? '';
    final rating = product['rating'] ?? 0.0;
    final reviewCount = product['reviewCount'] ?? 0;
    final discount = product['discount'] ?? 0.0;
    final inStock = product['inStock'] ?? true;
    final productId = product['id']?.toString() ??
        product['_id']?.toString() ??
        product['productId']?.toString();

    // --- Static Product Image Asset Paths (like cart) ---
    String? staticAssetPath;
    // Electronics
    const electronicsAssets = {
      '6819e22b123a4faad16613be':
          'assets/electronics_products/mobile_and_tablet/mobile_and_tablet1/1.png',
      '6819e22b123a4faad16613bf':
          'assets/electronics_products/mobile_and_tablet/mobile_and_tablet2/1.png',
      '6819e22b123a4faad16613c0':
          'assets/electronics_products/mobile_and_tablet/mobile_and_tablet3/1.png',
      '6819e22b123a4faad16613c1':
          'assets/electronics_products/mobile_and_tablet/mobile_and_tablet4/1.png',
      '6819e22b123a4faad16613c3':
          'assets/electronics_products/mobile_and_tablet/mobile_and_tablet5/1.png',
      '6819e22b123a4faad16613c4':
          'assets/electronics_products/tvscreens/tv1/1.png',
      '6819e22b123a4faad16613c5':
          'assets/electronics_products/tvscreens/tv2/1.png',
      '6819e22b123a4faad16613c6':
          'assets/electronics_products/tvscreens/tv3/1.png',
      '6819e22b123a4faad16613c7':
          'assets/electronics_products/tvscreens/tv4/1.png',
      '6819e22b123a4faad16613c8':
          'assets/electronics_products/tvscreens/tv5/1.png',
      '6819e22b123a4faad16613c9':
          'assets/electronics_products/Laptop/Laptop1/1.png',
      '6819e22b123a4faad16613ca':
          'assets/electronics_products/Laptop/Laptop2/1.png',
      '6819e22b123a4faad16613cb':
          'assets/electronics_products/Laptop/Laptop3/1.png',
      '6819e22b123a4faad16613cc':
          'assets/electronics_products/Laptop/Laptop4/1.png',
      '6819e22b123a4faad16613cd':
          'assets/electronics_products/Laptop/Laptop5/1.png',
    };
    // Beauty
    const beautyAssets = {
      '682b00d16977bd89257c0e9d': 'assets/beauty_products/makeup_1/1.png',
      '682b00d16977bd89257c0e9e': 'assets/beauty_products/makeup_2/1.png',
      '682b00d16977bd89257c0e9f': 'assets/beauty_products/makeup_3/1.png',
      '682b00d16977bd89257c0ea0': 'assets/beauty_products/makeup_4/1.png',
      '682b00d16977bd89257c0ea1': 'assets/beauty_products/makeup_5/1.png',
      '682b00d16977bd89257c0ea2': 'assets/beauty_products/skincare_1/1.png',
      '682b00d16977bd89257c0ea3': 'assets/beauty_products/skincare_2/1.png',
      '682b00d16977bd89257c0ea4': 'assets/beauty_products/skincare_3/1.png',
      '682b00d16977bd89257c0ea5': 'assets/beauty_products/skincare_4/1.png',
      '682b00d16977bd89257c0ea6': 'assets/beauty_products/skincare_5/1.png',
      '682b00d16977bd89257c0ea7': 'assets/beauty_products/haircare_1/1.png',
      '682b00d16977bd89257c0ea8': 'assets/beauty_products/haircare_2/1.png',
      '682b00d16977bd89257c0ea9': 'assets/beauty_products/haircare_3/1.png',
      '682b00d16977bd89257c0eaa': 'assets/beauty_products/haircare_4/1.png',
      '682b00d16977bd89257c0eab': 'assets/beauty_products/haircare_5/1.png',
      // Fragrance products
      '682b00d16977bd89257c0eb1': 'assets/beauty_products/fragrance_1/1.png',
      '682b00d16977bd89257c0eb2': 'assets/beauty_products/fragrance_1/2.png',
      '682b00d16977bd89257c0eb3': 'assets/beauty_products/fragrance_2/1.png',
      '682b00d16977bd89257c0eb4': 'assets/beauty_products/fragrance_2/2.png',
      '682b00d16977bd89257c0eb5': 'assets/beauty_products/fragrance_3/1.png',
      '682b00d16977bd89257c0eb6': 'assets/beauty_products/fragrance_3/2.png',
      '682b00d16977bd89257c0eb7': 'assets/beauty_products/fragrance_3/3.png',
      '682b00d16977bd89257c0eb8': 'assets/beauty_products/fragrance_4/1.png',
      '682b00d16977bd89257c0eb9': 'assets/beauty_products/fragrance_4/2.png',
      '682b00d16977bd89257c0eba': 'assets/beauty_products/fragrance_4/3.png',
      '682b00d16977bd89257c0ebb': 'assets/beauty_products/fragrance_5/1.png',
      '682b00d16977bd89257c0ebc': 'assets/beauty_products/fragrance_5/2.png',
      '682b00d16977bd89257c0ebd': 'assets/beauty_products/fragrance_5/3.png',
    };
    // Appliances
    const appliancesAssets = {
      '68252918a68b49cb06164204': 'assets/appliances/product1/1.png',
      '68252918a68b49cb06164205': 'assets/appliances/product2/1.png',
      '68252918a68b49cb06164206': 'assets/appliances/product3/1.png',
      '68252918a68b49cb06164207': 'assets/appliances/product4/1.png',
      '68252918a68b49cb06164208': 'assets/appliances/product5/1.png',
      '68252918a68b49cb06164209': 'assets/appliances/product6/1.png',
      '68252918a68b49cb0616420a': 'assets/appliances/product7/1.png',
      '68252918a68b49cb0616420b': 'assets/appliances/product8/1.png',
      '68252918a68b49cb0616420c': 'assets/appliances/product9/1.png',
      '68252918a68b49cb0616420d': 'assets/appliances/product10/1.png',
      '68252918a68b49cb0616420e': 'assets/appliances/product11/1.png',
      '68252918a68b49cb0616420f': 'assets/appliances/product12/1.png',
      '68252918a68b49cb06164210': 'assets/appliances/product13/1.png',
      '68252918a68b49cb06164211': 'assets/appliances/product14/1.png',
      '68252918a68b49cb06164212': 'assets/appliances/product15/1.png',
    };
    // Fashion
    const fashionAssets = {
      '682b00c26977bd89257c0e8e':
          'assets/Fashion_products/Women_Fashion/women_fashion1/1.png',
      '682b00c26977bd89257c0e8f':
          'assets/Fashion_products/Women_Fashion/women_fashion2/1.png',
      '682b00c26977bd89257c0e90':
          'assets/Fashion_products/Women_Fashion/women_fashion3/1.png',
      '682b00c26977bd89257c0e91':
          'assets/Fashion_products/Women_Fashion/women_fashion4/1.png',
      '682b00c26977bd89257c0e92':
          'assets/Fashion_products/Women_Fashion/women_fashion5/1.png',
      '682b00c26977bd89257c0e93':
          'assets/Fashion_products/Men_Fashion/men_fashion1/navy/1.png',
      '682b00c26977bd89257c0e94':
          'assets/Fashion_products/Men_Fashion/men_fashion2/light_blue/1.png',
      '682b00c26977bd89257c0e95':
          'assets/Fashion_products/Men_Fashion/men_fashion3/1.png',
      '682b00c26977bd89257c0e96':
          'assets/Fashion_products/Men_Fashion/men_fashion4/black/1.png',
      '682b00c26977bd89257c0e97':
          'assets/Fashion_products/Men_Fashion/men_fashion5/1.png',
      '682b00c26977bd89257c0e98':
          'assets/Fashion_products/Kids_Fashion/kids_fashion1/1.png',
      '682b00c26977bd89257c0e99':
          'assets/Fashion_products/Kids_Fashion/kids_fashion2/1.png',
      '682b00c26977bd89257c0e9a':
          'assets/Fashion_products/Kids_Fashion/kids_fashion3/1.png',
      '682b00c26977bd89257c0e9b':
          'assets/Fashion_products/Kids_Fashion/kids_fashion4/1.png',
      '682b00c26977bd89257c0e9c':
          'assets/Fashion_products/Kids_Fashion/kids_fashion5/1.png',
    };
    // Home
    const homeAssets = {
      '681dab0df9c9147444b452cd':
          'assets/Home_products/furniture/furniture1/1.png',
      '681dab0df9c9147444b452ce':
          'assets/Home_products/furniture/furniture2/1.png',
      '681dab0df9c9147444b452cf':
          'assets/Home_products/furniture/furniture3/1.png',
      '681dab0df9c9147444b452d0':
          'assets/Home_products/furniture/furniture4/1.png',
      '681dab0df9c9147444b452d1':
          'assets/Home_products/furniture/furniture5/1.png',
      '681dab0df9c9147444b452d2':
          'assets/Home_products/home-decor/home_decor1/1.png',
      '681dab0df9c9147444b452d3':
          'assets/Home_products/home-decor/home_decor2/1.png',
      '681dab0df9c9147444b452d4':
          'assets/Home_products/home-decor/home_decor3/1.png',
      '681dab0df9c9147444b452d5':
          'assets/Home_products/home-decor/home_decor4/1.png',
      '681dab0df9c9147444b452d6':
          'assets/Home_products/home-decor/home_decor5/1.png',
      '681dab0df9c9147444b452d7': 'assets/Home_products/kitchen/kitchen1/1.png',
      '681dab0df9c9147444b452d8': 'assets/Home_products/kitchen/kitchen2/1.png',
      '681dab0df9c9147444b452d9': 'assets/Home_products/kitchen/kitchen3/1.png',
      '681dab0df9c9147444b452da': 'assets/Home_products/kitchen/kitchen4/1.png',
      '681dab0df9c9147444b452db': 'assets/Home_products/kitchen/kitchen5/1.png',
      '681dab0df9c9147444b452dc':
          'assets/Home_products/bath_and_bedding/bath1/1.png',
      '681dab0df9c9147444b452dd':
          'assets/Home_products/bath_and_bedding/bath2/1.png',
      '681dab0df9c9147444b452de':
          'assets/Home_products/bath_and_bedding/bath3/1.png',
      '681dab0df9c9147444b452df':
          'assets/Home_products/bath_and_bedding/bath4/1.png',
      '681dab0df9c9147444b452e0':
          'assets/Home_products/bath_and_bedding/bath5/1.png',
    };
    // Video Games
    const videoGamesAssets = {
      '682b00a46977bd89257c0e80':
          'assets/videogames_products/Consoles/console1/1.png',
      '682b00a46977bd89257c0e81':
          'assets/videogames_products/Consoles/console2/1.png',
      '682b00a46977bd89257c0e82':
          'assets/videogames_products/Consoles/console3/1.png',
      '682b00a46977bd89257c0e83':
          'assets/videogames_products/Consoles/console4/1.png',
      '682b00a46977bd89257c0e84':
          'assets/videogames_products/Consoles/console5/1.png',
      '682b00a46977bd89257c0e85':
          'assets/videogames_products/Controllers/controller1/1.png',
      '682b00a46977bd89257c0e86':
          'assets/videogames_products/Controllers/controller2/1.png',
      '682b00a46977bd89257c0e87':
          'assets/videogames_products/Controllers/controller3/1.png',
      '682b00a46977bd89257c0e88':
          'assets/videogames_products/Controllers/controller4/1.png',
      '682b00a46977bd89257c0e89':
          'assets/videogames_products/Controllers/controller5/1.png',
      '682b00a46977bd89257c0e8a':
          'assets/videogames_products/Accessories/accessory1/1.png',
      '682b00a46977bd89257c0e8b':
          'assets/videogames_products/Accessories/accessory2/1.png',
      '682b00a46977bd89257c0e8c':
          'assets/videogames_products/Accessories/accessory3/1.png',
      '682b00a46977bd89257c0e8d':
          'assets/videogames_products/Accessories/accessory4/1.png',
    };
    if (electronicsAssets.containsKey(productId))
      staticAssetPath = electronicsAssets[productId];
    if (beautyAssets.containsKey(productId))
      staticAssetPath = beautyAssets[productId];
    if (appliancesAssets.containsKey(productId))
      staticAssetPath = appliancesAssets[productId];
    if (fashionAssets.containsKey(productId))
      staticAssetPath = fashionAssets[productId];
    if (homeAssets.containsKey(productId))
      staticAssetPath = homeAssets[productId];
    if (videoGamesAssets.containsKey(productId))
      staticAssetPath = videoGamesAssets[productId];

    return Material(
      color: isHighlighted
          ? theme.colorScheme.primary.withOpacity(0.1)
          : Colors.transparent,
      child: InkWell(
        onTap: () => _handleProductSelection(product),
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Container(
            width: double.infinity,
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
                    child: staticAssetPath != null
                        ? Image.asset(
                            staticAssetPath,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) => Icon(
                              Icons.image_not_supported,
                              color: Colors.grey[400],
                              size: 24,
                            ),
                          )
                        : images.isNotEmpty
                            ? Image.network(
                                images.first,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    Icon(
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
                                color:
                                    isDark ? Colors.grey[200] : Colors.grey[700],
                              ),
                            ),
                            if (reviewCount > 0) ...[
                              Text(
                                ' (${reviewCount})',
                                style: TextStyles.regular13.copyWith(
                                  color: isDark
                                      ? Colors.grey[400]
                                      : Colors.grey[600],
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
                              color:
                                  inStock ? Colors.green[100] : Colors.red[100],
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              inStock ? 'In Stock' : 'Out of Stock',
                              style: TextStyles.bold13.copyWith(
                                color:
                                    inStock ? Colors.green[700] : Colors.red[700],
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
      ),
    );
  }

  // 4. Filter _searchResults before displaying
  List<Map<String, dynamic>> _applyAdvancedFilters(List<Map<String, dynamic>> results) {
    return results.where((product) {
      final price = product['price'] as num? ?? 0;
      final rating = product['rating'] as num? ?? 0;
      final brand = product['brand'] as String? ?? '';
      final category = product['category'] as String? ?? '';
      final categoryMatch = _activeFilters.isEmpty || _activeFilters.contains(category);
      final priceMatch = price >= _priceRange.start && price <= _priceRange.end;
      final ratingMatch = rating >= _minRating;
      final brandMatch = _selectedBrand == null || brand == _selectedBrand;
      return categoryMatch && priceMatch && ratingMatch && brandMatch;
    }).toList();
  }
}
