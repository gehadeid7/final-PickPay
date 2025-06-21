import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/widgets/brand_filter_widget.dart';
import 'package:pickpay/features/categories_pages/widgets/deals_filter_widget.dart';
import 'package:pickpay/features/categories_pages/widgets/free_delivery_filter_widget.dart';
import 'package:pickpay/features/categories_pages/widgets/fulfillment_filter_widget.dart';
import 'package:pickpay/features/categories_pages/widgets/price_range_filter.dart';
import 'package:pickpay/features/categories_pages/widgets/product_card.dart';
import 'package:pickpay/features/categories_pages/widgets/rating_filter.dart';
import 'package:pickpay/features/categories_pages/widgets/seller_filter_widget.dart';
import 'package:pickpay/features/categories_pages/widgets/sort_filter_widget.dart';
import 'package:pickpay/core/widgets/search_text_field.dart';
import 'package:pickpay/core/services/ai_search_service.dart';
import 'package:pickpay/services/api_service.dart';
import 'dart:async';

class BaseCategoryView extends StatefulWidget {
  final String categoryName;
  final List<ProductsViewsModel> products;
  final Widget Function(String productId) productDetailBuilder;

  const BaseCategoryView({
    super.key,
    required this.categoryName,
    required this.products,
    required this.productDetailBuilder,
  });

  @override
  State<BaseCategoryView> createState() => _BaseCategoryViewState();
}

class _BaseCategoryViewState extends State<BaseCategoryView>
    with SingleTickerProviderStateMixin {
  String? _selectedBrand;
  String? _selectedSeller;
  String? _selectedFulfillment;
  String? _selectedDealType;
  String? _selectedDeliveryType;
  double _minRating = 0;
  late RangeValues _priceRange;
  bool _isFilterExpanded = false;
  late AnimationController _filterController;
  late ScrollController _scrollController;
  bool _showScrollToTop = false;
  SortOption _sortOption = SortOption.none;

  // Search related variables
  final TextEditingController _searchController = TextEditingController();
  final AISearchService _aiService = AISearchService(apiService: ApiService());
  List<Map<String, dynamic>> _searchResults = [];
  List<String> _suggestions = [];
  bool _isSearchLoading = false;
  Timer? _searchDebounce;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _initPriceRange();
    _filterController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
    _aiService.initialize();
  }

  void _onScroll() {
    if (_scrollController.offset > 500 && !_showScrollToTop) {
      setState(() => _showScrollToTop = true);
    } else if (_scrollController.offset <= 500 && _showScrollToTop) {
      setState(() => _showScrollToTop = false);
    }
  }

  @override
  void dispose() {
    _filterController.dispose();
    _scrollController.dispose();
    _searchController.dispose();
    _searchDebounce?.cancel();
    super.dispose();
  }

  void _initPriceRange() {
    final maxPrice = widget.products
        .map((product) => product.price)
        .reduce((a, b) => a > b ? a : b);
    _priceRange = RangeValues(0, maxPrice);
  }

  Future<void> _handleSearch(String query) async {
    if (query.isEmpty) {
      setState(() {
        _searchResults = [];
        _suggestions = [];
        _searchQuery = '';
      });
      return;
    }

    _searchDebounce?.cancel();
    _searchDebounce = Timer(const Duration(milliseconds: 300), () async {
      setState(() {
        _isSearchLoading = true;
        _searchQuery = query;
      });

      try {
        final suggestions = await _aiService.fetchLiveSuggestions(query);
        final results = await _aiService.searchProducts(query);

        if (mounted) {
          final processedResults = results.map((result) {
            return {
              'id': result['id'] ?? result['_id'] ?? '',
              'title': result['title'] ?? result['name'] ?? '',
              'price': result['price'] ?? 0.0,
              'images': result['images'] ?? result['imagePaths'] ?? [],
              'brand': result['brand'] ?? '',
              'category': result['category'] ?? '',
              'description':
                  result['description'] ?? result['aboutThisItem'] ?? '',
              'rating': result['rating'] ?? result['ratingsAverage'] ?? 0.0,
              'reviewCount':
                  result['reviewCount'] ?? result['ratingsQuantity'] ?? 0,
            };
          }).toList();

          setState(() {
            _suggestions = suggestions;
            _searchResults = processedResults;
            _isSearchLoading = false;
          });
        }
      } catch (e) {
        if (mounted) {
          setState(() {
            _isSearchLoading = false;
          });
        }
      }
    });
  }

  List<ProductsViewsModel> get _filteredProducts {
    List<ProductsViewsModel> filtered = widget.products;

    // Apply search filter first
    if (_searchQuery.isNotEmpty) {
      final lowerQuery = _searchQuery.toLowerCase();
      filtered = filtered.where((product) {
        final title = product.title.toLowerCase();
        final brand = product.brand?.toLowerCase() ?? '';
        final category = product.category?.toLowerCase() ?? '';
        return title.contains(lowerQuery) ||
            brand.contains(lowerQuery) ||
            category.contains(lowerQuery);
      }).toList();
    }

    // Apply other filters
    filtered = filtered.where((product) {
      // Debug logging for brand filtering
      if (_selectedBrand != null && _selectedBrand != 'All Brands') {
        print('Filtering - Selected Brand: $_selectedBrand');
        print('Filtering - Product Brand: ${product.brand}');
        print('Filtering - Brand Match: ${product.brand == _selectedBrand}');
      }

      final brandMatch = _selectedBrand == null ||
          _selectedBrand!.isEmpty ||
          _selectedBrand == 'All Brands' ||
          product.brand == _selectedBrand;
      final sellerMatch = _selectedSeller == null ||
          _selectedSeller!.isEmpty ||
          _selectedSeller == 'All Sellers' ||
          product.soldBy == _selectedSeller;
      final fulfillmentMatch = _selectedFulfillment == null ||
          _selectedFulfillment == 'All' ||
          (_selectedFulfillment == 'PickPay Fulfilled' &&
              product.isPickPayFulfilled == true) ||
          (_selectedFulfillment == 'Seller Fulfilled' &&
              product.isPickPayFulfilled == false);
      final dealMatch = _selectedDealType == null ||
          _selectedDealType == 'All' ||
          (_selectedDealType == 'Fresh Sale' &&
              product.originalPrice != null &&
              product.originalPrice! > product.price);
      final deliveryMatch = _selectedDeliveryType == null ||
          _selectedDeliveryType == 'All' ||
          (_selectedDeliveryType == 'Free Delivery' &&
              product.hasFreeDelivery == true);
      final ratingMatch =
          product.rating != null && product.rating! >= _minRating;
      final priceMatch = product.price >= _priceRange.start &&
          product.price <= _priceRange.end;

      final result = brandMatch &&
          sellerMatch &&
          fulfillmentMatch &&
          dealMatch &&
          deliveryMatch &&
          ratingMatch &&
          priceMatch;

      // Debug logging for overall filter result
      if (_selectedBrand != null && _selectedBrand != 'All Brands') {
        print('Filtering - Overall Result: $result');
      }

      return result;
    }).toList();

    // Apply sorting
    switch (_sortOption) {
      case SortOption.priceAsc:
        filtered.sort((a, b) => a.price.compareTo(b.price));
        break;
      case SortOption.priceDesc:
        filtered.sort((a, b) => b.price.compareTo(a.price));
        break;
      case SortOption.ratingDesc:
        filtered.sort((a, b) {
          final aRating = a.rating ?? 0.0;
          final bRating = b.rating ?? 0.0;
          final ratingCompare = bRating.compareTo(aRating);
          if (ratingCompare != 0) return ratingCompare;
          final aReviews = a.reviewCount ?? 0;
          final bReviews = b.reviewCount ?? 0;
          return bReviews.compareTo(aReviews);
        });
        break;
      case SortOption.ratingAsc:
        filtered.sort((a, b) {
          final aRating = a.rating ?? 0.0;
          final bRating = b.rating ?? 0.0;
          final ratingCompare = aRating.compareTo(bRating);
          if (ratingCompare != 0) return ratingCompare;
          final aReviews = a.reviewCount ?? 0;
          final bReviews = b.reviewCount ?? 0;
          return aReviews.compareTo(bReviews);
        });
        break;
      case SortOption.none:
        break;
    }

    return filtered;
  }

  void _navigateToProductDetail(BuildContext context, String productId) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            widget.productDetailBuilder(productId),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
        transitionDuration: const Duration(milliseconds: 300),
      ),
    );
  }

  bool get _hasActiveFilters {
    final maxPrice = widget.products
        .map((product) => product.price)
        .reduce((a, b) => a > b ? a : b);

    return _selectedBrand != null ||
        _selectedSeller != null ||
        _selectedFulfillment != null ||
        _selectedDealType != null ||
        _selectedDeliveryType != null ||
        _minRating > 0 ||
        _priceRange.start > 0 ||
        _priceRange.end < maxPrice ||
        _sortOption != SortOption.none;
  }

  void _resetAllFilters() {
    setState(() {
      _selectedBrand = null;
      _selectedSeller = null;
      _selectedFulfillment = null;
      _selectedDealType = null;
      _selectedDeliveryType = null;
      _minRating = 0;
      _initPriceRange();
      _sortOption = SortOption.none;
    });
  }

  Widget _buildActiveFilter(String label, VoidCallback onRemove) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: isDarkMode ? Color(0xFF2A2A2A) : Colors.grey.shade100,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color:
              isDarkMode ? Colors.white.withOpacity(0.1) : Colors.grey.shade200,
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: isDarkMode
                  ? Colors.white.withOpacity(0.9)
                  : Colors.grey.shade800,
            ),
          ),
          const SizedBox(width: 8),
          InkWell(
            onTap: onRemove,
            borderRadius: BorderRadius.circular(12),
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: isDarkMode
                    ? Colors.white.withOpacity(0.1)
                    : Colors.grey.shade200,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                Icons.close_rounded,
                size: 14,
                color: isDarkMode
                    ? Colors.white.withOpacity(0.8)
                    : Colors.grey.shade600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterButton(
    String label,
    IconData icon, {
    required bool isActive,
    required VoidCallback onTap,
  }) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    final Color activeColor = isDarkMode
        ? theme.colorScheme.primary.withOpacity(0.15)
        : theme.colorScheme.primary.withOpacity(0.12);

    final Color inactiveColor =
        isDarkMode ? Color(0xFF2A2A2A) : Colors.grey.shade100;

    final Color borderColor = isActive
        ? isDarkMode
            ? theme.colorScheme.primary.withOpacity(0.4)
            : theme.colorScheme.primary.withOpacity(0.2)
        : isDarkMode
            ? Colors.white.withOpacity(0.08)
            : Colors.grey.shade200;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: isActive ? activeColor : inactiveColor,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: borderColor,
                width: 1,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  size: 20,
                  color: isActive
                      ? theme.colorScheme.primary
                      : isDarkMode
                          ? Colors.white.withOpacity(0.9)
                          : Colors.grey.shade700,
                ),
                const SizedBox(width: 8),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
                    color: isActive
                        ? theme.colorScheme.primary
                        : isDarkMode
                            ? Colors.white.withOpacity(0.9)
                            : Colors.grey.shade700,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    final maxPrice = widget.products
        .map((product) => product.price)
        .reduce((a, b) => a > b ? a : b);

    return Scaffold(
      backgroundColor: isDarkMode ? Color(0xFF121212) : Colors.white,
      body: Stack(
        children: [
          CustomScrollView(
            controller: _scrollController,
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverAppBar(
                expandedHeight: 80,
                floating: true,
                pinned: true,
                elevation: 0,
                toolbarHeight: 60,
                backgroundColor: isDarkMode ? Color(0xFF121212) : Colors.white,
                leading: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: IconButton(
                    icon: Icon(
                      Icons.arrow_back_rounded,
                      size: 26,
                      color: isDarkMode ? Colors.white : Colors.grey.shade800,
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ),
                flexibleSpace: FlexibleSpaceBar(
                  expandedTitleScale: 1.0,
                  centerTitle: true,
                  titlePadding: const EdgeInsets.only(bottom: 12),
                  title: Text(
                    widget.categoryName,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: isDarkMode ? Colors.white : Colors.grey.shade800,
                      fontWeight: FontWeight.w600,
                      fontSize: 28,
                    ),
                  ),
                  background: Container(
                    decoration: BoxDecoration(
                      color: isDarkMode ? Color(0xFF121212) : Colors.white,
                      border: Border(
                        bottom: BorderSide(
                          color: isDarkMode
                              ? Colors.white.withOpacity(0.05)
                              : Colors.grey.shade100,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              // Search Bar
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                  child: SearchTextField(
                    controller: _searchController,
                    onSearch: _handleSearch,
                  ),
                ),
              ),

              // Filters Section
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                  child: Container(
                    decoration: BoxDecoration(
                      color: isDarkMode ? Color(0xFF1E1E1E) : Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(
                        color: isDarkMode
                            ? Colors.white.withOpacity(0.05)
                            : Colors.grey.shade100,
                        width: 1,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Active Filters Bar
                        Container(
                          padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
                          decoration: BoxDecoration(
                            color:
                                isDarkMode ? Color(0xFF1E1E1E) : Colors.white,
                            borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(24)),
                          ),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            physics: const BouncingScrollPhysics(),
                            child: Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 8),
                                  decoration: BoxDecoration(
                                    color: theme.colorScheme.primary
                                        .withOpacity(isDarkMode ? 0.15 : 0.12),
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                      color: theme.colorScheme.primary
                                          .withOpacity(isDarkMode ? 0.3 : 0.1),
                                      width: 1,
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.filter_list_rounded,
                                        size: 16,
                                        color: theme.colorScheme.primary,
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        '${_filteredProducts.length} Products',
                                        style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600,
                                          color: theme.colorScheme.primary,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 12),
                                if (_selectedBrand != null)
                                  _buildActiveFilter(
                                    'Brand: $_selectedBrand',
                                    () => setState(() => _selectedBrand = null),
                                  ),
                                if (_selectedSeller != null)
                                  _buildActiveFilter(
                                    'Seller: $_selectedSeller',
                                    () =>
                                        setState(() => _selectedSeller = null),
                                  ),
                                if (_selectedFulfillment != null)
                                  _buildActiveFilter(
                                    'Fulfillment: $_selectedFulfillment',
                                    () => setState(
                                        () => _selectedFulfillment = null),
                                  ),
                                if (_selectedDealType != null)
                                  _buildActiveFilter(
                                    'Deals: $_selectedDealType',
                                    () => setState(
                                        () => _selectedDealType = null),
                                  ),
                                if (_selectedDeliveryType != null)
                                  _buildActiveFilter(
                                    'Delivery: $_selectedDeliveryType',
                                    () => setState(
                                        () => _selectedDeliveryType = null),
                                  ),
                                if (_sortOption != SortOption.none)
                                  _buildActiveFilter(
                                    _sortOption == SortOption.priceAsc
                                        ? 'Price: Low-High'
                                        : _sortOption == SortOption.priceDesc
                                            ? 'Price: High-Low'
                                            : _sortOption ==
                                                    SortOption.ratingDesc
                                                ? 'Rating: High-Low'
                                                : 'Rating: Low-High',
                                    () => setState(
                                        () => _sortOption = SortOption.none),
                                  ),
                                if (_minRating > 0)
                                  _buildActiveFilter(
                                    '${_minRating.toStringAsFixed(1)}★+',
                                    () => setState(() => _minRating = 0),
                                  ),
                                if (_priceRange.start > 0 ||
                                    _priceRange.end < maxPrice)
                                  _buildActiveFilter(
                                    'EGP ${_priceRange.start.round()}-${_priceRange.end.round()}',
                                    () => setState(() => _initPriceRange()),
                                  ),
                                if (_hasActiveFilters) ...[
                                  const SizedBox(width: 12),
                                  TextButton.icon(
                                    onPressed: _resetAllFilters,
                                    style: TextButton.styleFrom(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12, vertical: 6),
                                      foregroundColor: theme.colorScheme.error,
                                    ),
                                    icon: const Icon(Icons.refresh_rounded,
                                        size: 16),
                                    label: const Text(
                                      'Reset All',
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ),

                        // Filter Options
                        Container(
                          height: 64,
                          padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            physics: const BouncingScrollPhysics(),
                            child: Row(
                              children: [
                                _buildFilterButton(
                                  'Brand',
                                  Icons.business_rounded,
                                  isActive: _selectedBrand != null,
                                  onTap: () => _showFilterBottomSheet(
                                    context,
                                    'Select Brand',
                                    BrandFilterWidget(
                                      products: widget.products,
                                      selectedBrand: _selectedBrand,
                                      currentCategory: widget.categoryName,
                                      onBrandChanged: (brand) {
                                        print(
                                            'BaseCategoryView - Brand changed to: $brand');
                                        setState(() => _selectedBrand = brand);
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ),
                                ),
                                _buildFilterButton(
                                  'Price',
                                  Icons.payments_rounded,
                                  isActive: _priceRange.start > 0 ||
                                      _priceRange.end <
                                          widget.products
                                              .map((product) => product.price)
                                              .reduce((a, b) => a > b ? a : b),
                                  onTap: () => _showFilterBottomSheet(
                                    context,
                                    'Price Range',
                                    PriceRangeFilterWidget(
                                      values: _priceRange,
                                      maxPrice: widget.products
                                          .map((product) => product.price)
                                          .reduce((a, b) => a > b ? a : b),
                                      onChanged: (range) {
                                        setState(() => _priceRange = range);
                                      },
                                    ),
                                  ),
                                ),
                                _buildFilterButton(
                                  'Rating',
                                  Icons.star_rounded,
                                  isActive: _minRating > 0,
                                  onTap: () => _showFilterBottomSheet(
                                    context,
                                    'Minimum Rating',
                                    RatingFilterWidget(
                                      value: _minRating,
                                      onChanged: (rating) =>
                                          setState(() => _minRating = rating),
                                    ),
                                  ),
                                ),
                                _buildFilterButton(
                                  'Sort',
                                  Icons.sort_rounded,
                                  isActive: _sortOption != SortOption.none,
                                  onTap: () => _showFilterBottomSheet(
                                    context,
                                    'Sort By',
                                    SortFilterWidget(
                                      selectedOption: _sortOption,
                                      onChanged: (option) {
                                        setState(() => _sortOption = option);
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ),
                                ),
                                _buildFilterButton(
                                  'Seller',
                                  Icons.store_rounded,
                                  isActive: _selectedSeller != null,
                                  onTap: () => _showFilterBottomSheet(
                                    context,
                                    'Select Seller',
                                    SellerFilterWidget(
                                      products: widget.products,
                                      selectedSeller: _selectedSeller,
                                      onSellerChanged: (seller) {
                                        setState(
                                            () => _selectedSeller = seller);
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ),
                                ),
                                _buildFilterButton(
                                  'Deals',
                                  Icons.local_offer_rounded,
                                  isActive: _selectedDealType != null,
                                  onTap: () => _showFilterBottomSheet(
                                    context,
                                    'Select Deal Type',
                                    DealsFilterWidget(
                                      selectedDealType: _selectedDealType,
                                      onDealTypeChanged: (dealType) {
                                        setState(
                                            () => _selectedDealType = dealType);
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ),
                                ),
                                _buildFilterButton(
                                  'Fulfillment',
                                  Icons.inventory_2_rounded,
                                  isActive: _selectedFulfillment != null,
                                  onTap: () => _showFilterBottomSheet(
                                    context,
                                    'Select Fulfillment',
                                    FulfillmentFilterWidget(
                                      selectedFulfillment: _selectedFulfillment,
                                      onFulfillmentChanged: (fulfillment) {
                                        setState(() =>
                                            _selectedFulfillment = fulfillment);
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ),
                                ),
                                _buildFilterButton(
                                  'Delivery',
                                  Icons.local_shipping_rounded,
                                  isActive: _selectedDeliveryType != null,
                                  onTap: () => _showFilterBottomSheet(
                                    context,
                                    'Select Delivery Type',
                                    FreeDeliveryFilterWidget(
                                      selectedDeliveryType:
                                          _selectedDeliveryType,
                                      onDeliveryTypeChanged: (deliveryType) {
                                        setState(() => _selectedDeliveryType =
                                            deliveryType);
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Products Grid
              SliverPadding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                sliver: SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    childAspectRatio: 0.68,
                    mainAxisExtent: 280,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final product = _filteredProducts[index];
                      return AnimatedScale(
                        scale: 1.0,
                        duration: Duration(milliseconds: 200 + (index * 50)),
                        curve: Curves.easeOutCubic,
                        child: AnimatedOpacity(
                          duration: Duration(milliseconds: 200 + (index * 50)),
                          curve: Curves.easeOutCubic,
                          opacity: 1.0,
                          child: ProductCard(
                            id: product.id,
                            name: product.title,
                            imagePaths: product.imagePaths ?? [],
                            price: product.price,
                            originalPrice: product.originalPrice ?? 0,
                            rating: product.rating ?? 0,
                            reviewCount: product.reviewCount ?? 0,
                            onTap: () =>
                                _navigateToProductDetail(context, product.id),
                          ),
                        ),
                      );
                    },
                    childCount: _filteredProducts.length,
                  ),
                ),
              ),

              // Empty State
              SliverPadding(
                padding: const EdgeInsets.only(bottom: 20),
                sliver: SliverToBoxAdapter(
                  child: _filteredProducts.isEmpty
                      ? Center(
                          child: Padding(
                            padding: const EdgeInsets.all(32),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.search_off_rounded,
                                  size: 48,
                                  color: isDarkMode
                                      ? Colors.grey
                                      : Colors.grey.shade400,
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  'No products found',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: isDarkMode
                                        ? Colors.grey
                                        : Colors.grey.shade600,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Try adjusting your filters',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: isDarkMode
                                        ? Colors.grey
                                        : Colors.grey.shade500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      : const SizedBox(),
                ),
              ),
            ],
          ),

          // Scroll to Top Button
          AnimatedPositioned(
            duration: const Duration(milliseconds: 300),
            right: 16,
            bottom: _showScrollToTop ? 16 : -60,
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 300),
              opacity: _showScrollToTop ? 1.0 : 0.0,
              child: FloatingActionButton(
                mini: true,
                onPressed: () {
                  _scrollController.animateTo(
                    0,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeOutCubic,
                  );
                },
                backgroundColor: theme.colorScheme.primary.withOpacity(0.9),
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(Icons.keyboard_arrow_up, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showFilterBottomSheet(
      BuildContext context, String title, Widget content) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.85,
          ),
          margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          decoration: BoxDecoration(
            color: isDarkMode ? Color(0xFF1E1E1E) : Colors.white,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: isDarkMode
                  ? Colors.white.withOpacity(0.05)
                  : Colors.grey.shade100,
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(isDarkMode ? 0.5 : 0.1),
                blurRadius: 24,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 12),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: isDarkMode
                      ? Colors.white.withOpacity(0.2)
                      : Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Flexible(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(24, 24, 24, 20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: isDarkMode
                                ? Colors.white
                                : const Color(0xFF2C3E50),
                          ),
                        ),
                        const SizedBox(height: 20),
                        content,
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
