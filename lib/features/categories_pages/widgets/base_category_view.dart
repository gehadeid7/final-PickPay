import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/widgets/brand_filter_widget.dart';
import 'package:pickpay/features/categories_pages/widgets/price_range_filter.dart';
import 'package:pickpay/features/categories_pages/widgets/product_card.dart';
import 'package:pickpay/features/categories_pages/widgets/rating_filter.dart';

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

class _BaseCategoryViewState extends State<BaseCategoryView> {
  String? _selectedBrand;
  double _minRating = 0;
  late RangeValues _priceRange;
  bool _isFilterExpanded = false;

  @override
  void initState() {
    super.initState();
    _initPriceRange();
  }

  void _initPriceRange() {
    final maxPrice = widget.products
        .map((product) => product.price)
        .reduce((a, b) => a > b ? a : b);
    _priceRange = RangeValues(0, maxPrice);
  }

  List<ProductsViewsModel> get _filteredProducts {
    return widget.products.where((product) {
      final brandMatch = _selectedBrand == null ||
          _selectedBrand!.isEmpty ||
          _selectedBrand == 'All Brands' ||
          product.brand == _selectedBrand;
      final ratingMatch =
          product.rating != null && product.rating! >= _minRating;
      final priceMatch = product.price >= _priceRange.start &&
          product.price <= _priceRange.end;
      return brandMatch && ratingMatch && priceMatch;
    }).toList();
  }

  void _navigateToProductDetail(BuildContext context, String productId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget.productDetailBuilder(productId),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final maxPrice = widget.products
        .map((product) => product.price)
        .reduce((a, b) => a > b ? a : b);

    final currentValues = RangeValues(
      _priceRange.start.clamp(0, maxPrice),
      _priceRange.end.clamp(0, maxPrice),
    );

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Custom App Bar
          SliverAppBar(
            expandedHeight: 120,
            floating: true,
            pinned: true,
            elevation: 0,
            backgroundColor: theme.scaffoldBackgroundColor,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                widget.categoryName,
                style: TextStyle(
                  color: theme.textTheme.titleLarge?.color,
                  fontWeight: FontWeight.bold,
                ),
              ),
              centerTitle: false,
              titlePadding: const EdgeInsets.only(left: 16, bottom: 16),
            ),
            actions: [
              // Active Filters Indicator
              if (_selectedBrand != null ||
                  _minRating > 0 ||
                  _priceRange.start > 0 ||
                  _priceRange.end < maxPrice)
                Container(
                  margin: const EdgeInsets.only(right: 8),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.check_circle_outline,
                        size: 16,
                        color: theme.colorScheme.primary,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'Filters Applied',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              // Filter Button with Badge
              Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(8),
                  onTap: () {
                    setState(() {
                      _isFilterExpanded = !_isFilterExpanded;
                    });
                  },
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        decoration: BoxDecoration(
                          color: _isFilterExpanded
                              ? theme.colorScheme.primary.withOpacity(0.1)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.all(8),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              _isFilterExpanded
                                  ? Icons.tune
                                  : Icons.tune_outlined,
                              color: _isFilterExpanded
                                  ? theme.colorScheme.primary
                                  : theme.iconTheme.color,
                            ),
                            if (!_isFilterExpanded) ...[
                              const SizedBox(width: 4),
                              Text(
                                'Filter',
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: theme.iconTheme.color,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                      if (!_isFilterExpanded &&
                          (_selectedBrand != null ||
                              _minRating > 0 ||
                              _priceRange.start > 0 ||
                              _priceRange.end < maxPrice))
                        Positioned(
                          top: 6,
                          right: 6,
                          child: Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: theme.colorScheme.primary,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 8),
            ],
          ),

          // Filters Section
          SliverToBoxAdapter(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              height: _isFilterExpanded ? null : 0,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 200),
                opacity: _isFilterExpanded ? 1.0 : 0.0,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Card(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                      side: BorderSide(
                        color: theme.dividerColor.withOpacity(0.1),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.tune,
                                    color: theme.colorScheme.primary,
                                    size: 20,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    'Filters',
                                    style:
                                        theme.textTheme.titleMedium?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: theme.colorScheme.primary,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    '${_filteredProducts.length} Products',
                                    style: theme.textTheme.bodyMedium?.copyWith(
                                      color: theme.textTheme.bodySmall?.color,
                                    ),
                                  ),
                                  if (_selectedBrand != null ||
                                      _minRating > 0 ||
                                      _priceRange.start > 0 ||
                                      _priceRange.end < maxPrice) ...[
                                    const SizedBox(width: 12),
                                    TextButton(
                                      onPressed: () {
                                        setState(() {
                                          _selectedBrand = null;
                                          _minRating = 0;
                                          _initPriceRange();
                                        });
                                      },
                                      style: TextButton.styleFrom(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 12,
                                          vertical: 6,
                                        ),
                                        backgroundColor: theme.colorScheme.error
                                            .withOpacity(0.1),
                                      ),
                                      child: Text(
                                        'Clear All',
                                        style:
                                            theme.textTheme.bodySmall?.copyWith(
                                          color: theme.colorScheme.error,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          BrandFilterWidget(
                            products: widget.products,
                            selectedBrand: _selectedBrand,
                            onBrandChanged: (newBrand) {
                              setState(() {
                                _selectedBrand = newBrand;
                              });
                            },
                          ),
                          const Divider(height: 24),
                          PriceRangeFilterWidget(
                            values: currentValues,
                            maxPrice: maxPrice,
                            onChanged: (range) {
                              setState(() {
                                _priceRange = range;
                              });
                            },
                          ),
                          const SizedBox(height: 16),
                          RatingFilterWidget(
                            value: _minRating,
                            onChanged: (rating) =>
                                setState(() => _minRating = rating),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Products Grid
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final product = _filteredProducts[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: AnimatedScale(
                      scale: 1.0,
                      duration: Duration(milliseconds: 200 + (index * 50)),
                      child: AnimatedOpacity(
                        duration: Duration(milliseconds: 200 + (index * 50)),
                        opacity: 1.0,
                        child: SizedBox(
                          width: double.infinity,
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
                      ),
                    ),
                  );
                },
                childCount: _filteredProducts.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
