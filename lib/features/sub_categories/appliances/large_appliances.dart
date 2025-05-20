import 'package:flutter/material.dart';
import 'package:pickpay/core/widgets/build_appbar.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/products_views/appliances_products_views/appliances_product1.dart';
import 'package:pickpay/features/categories_pages/products_views/appliances_products_views/appliances_product2.dart';
import 'package:pickpay/features/categories_pages/products_views/appliances_products_views/appliances_product3.dart';
import 'package:pickpay/features/categories_pages/products_views/appliances_products_views/appliances_product4.dart';
import 'package:pickpay/features/categories_pages/products_views/appliances_products_views/appliances_product5.dart';
import 'package:pickpay/features/categories_pages/widgets/brand_filter_widget.dart';
import 'package:pickpay/features/categories_pages/widgets/price_range_filter.dart';
import 'package:pickpay/features/categories_pages/widgets/rating_filter.dart';
import 'package:pickpay/features/categories_pages/widgets/product_card.dart';
import 'package:pickpay/services/api_service.dart';

class LargeAppliances extends StatefulWidget {
  const LargeAppliances({super.key});

  @override
  State<LargeAppliances> createState() => _LargeAppliances();
}

class _LargeAppliances extends State<LargeAppliances> {
  String? _selectedBrand;
  double _minRating = 0;
  RangeValues? _priceRange;
  late Future<List<ProductsViewsModel>> _productsFuture;

  static final Map<String, Map<String, dynamic>> productData = {
    'Refrigerator': {
      'page': const AppliancesProduct3(),
      'rating': 4.5,
      'reviewCount': 12,
      'image': 'assets/appliances/product3/1.png',
      'brand': 'Generic',
    },
    'Water Dispenser': {
      'page': const AppliancesProduct1(),
      'rating': 3.9,
      'reviewCount': 9,
      'image': 'assets/appliances/product1/1.png',
      'brand': 'Generic',
    },
    'Stainless Steel Potato': {
      'page': const AppliancesProduct2(),
      'rating': 3.1,
      'reviewCount': 9,
      'image': 'assets/appliances/product2/1.png',
      'brand': 'Generic',
    },
    'Washing Machine': {
      'page': const AppliancesProduct4(),
      'rating': 4.2,
      'reviewCount': 14,
      'image': 'assets/appliances/product4/1.png',
      'brand': 'Generic',
    },
    'Dishwasher': {
      'page': const AppliancesProduct5(),
      'rating': 4.0,
      'reviewCount': 11,
      'image': 'assets/appliances/product5/1.png',
      'brand': 'Generic',
    },
  };

  @override
  void initState() {
    super.initState();
    _productsFuture = _loadProducts();
  }

  Future<List<ProductsViewsModel>> _loadProducts() async {
    final apiProducts = await ApiService().loadProducts();
    return apiProducts.map((apiProduct) {
      final matchingKey = productData.keys.firstWhere(
        (key) => apiProduct.name.toLowerCase().contains(key.toLowerCase()),
        orElse: () => '',
      );

      final brand = matchingKey.isNotEmpty
          ? productData[matchingKey]!['brand'] as String
          : 'Generic';

      return ProductsViewsModel(
        id: apiProduct.id,
        title: apiProduct.name,
        price: apiProduct.price,
        originalPrice: apiProduct.originalPrice,
        rating: productData[matchingKey]?['rating'] as double? ?? 4.0,
        reviewCount: productData[matchingKey]?['reviewCount'] as int? ?? 0,
        brand: brand,
        imagePaths: [productData[matchingKey]?['image'] as String? ?? ''],
      );
    }).toList();
  }

  List<ProductsViewsModel> _filterProducts(List<ProductsViewsModel> products) {
    return products.where((product) {
      final brandMatch = _selectedBrand == null ||
          _selectedBrand!.isEmpty ||
          _selectedBrand == 'All Brands' ||
          product.brand == _selectedBrand;

      final ratingMatch =
          product.rating != null && product.rating! >= _minRating;

      final priceMatch = _priceRange == null ||
          (product.price >= _priceRange!.start &&
              product.price <= _priceRange!.end);

      return brandMatch && ratingMatch && priceMatch;
    }).toList();
  }

  Widget? _findDetailPage(String productTitle) {
    for (var key in productData.keys) {
      if (productTitle.toLowerCase().contains(key.toLowerCase())) {
        return productData[key]!['page'] as Widget;
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context: context, title: 'Large Appliances'),
      body: FutureBuilder<List<ProductsViewsModel>>(
        future: _productsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, color: Colors.red, size: 60),
                  const SizedBox(height: 16),
                  Text(
                    'Error: ${snapshot.error}',
                    style: const TextStyle(fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => setState(() {
                      _productsFuture = _loadProducts();
                    }),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text(
                'No appliances available at the moment.',
                style: TextStyle(fontSize: 16),
              ),
            );
          }

          final products = snapshot.data!;
          final maxPrice =
              products.map((p) => p.price).reduce((a, b) => a > b ? a : b);
          final minPrice =
              products.map((p) => p.price).reduce((a, b) => a < b ? a : b);

          if (_priceRange == null) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              setState(() {
                _priceRange = RangeValues(minPrice, maxPrice);
              });
            });
            return const Center(child: CircularProgressIndicator());
          }

          final filteredProducts = _filterProducts(products);

          return RefreshIndicator(
            onRefresh: () async {
              setState(() {
                _productsFuture = _loadProducts();
              });
            },
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                // Filters section
                Card(
                  elevation: 2,
                  child: BrandFilterWidget(
                    products: products,
                    selectedBrand: _selectedBrand,
                    onBrandChanged: (newBrand) {
                      setState(() {
                        _selectedBrand = newBrand;
                      });
                    },
                  ),
                ),
                // Price and Rating filters in a row
                Row(
                  children: [
                    Expanded(
                      child: Card(
                        elevation: 2,
                        child: PriceRangeFilterWidget(
                          values: _priceRange!,
                          maxPrice: maxPrice,
                          onChanged: (range) =>
                              setState(() => _priceRange = range),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Card(
                        elevation: 2,
                        child: RatingFilterWidget(
                          value: _minRating,
                          onChanged: (rating) =>
                              setState(() => _minRating = rating),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Products list
                ...filteredProducts.map((product) {
                  final productPage = _findDetailPage(product.title);
                  if (productPage == null) return const SizedBox.shrink();

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: ProductCard(
                      id: product.id,
                      name: product.title,
                      imagePaths: product.imagePaths ?? [],
                      price: product.price,
                      originalPrice: product.originalPrice ?? 0,
                      rating: product.rating ?? 0,
                      reviewCount: product.reviewCount ?? 0,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => productPage),
                        );
                      },
                    ),
                  );
                }).toList(),
              ],
            ),
          );
        },
      ),
    );
  }
}
