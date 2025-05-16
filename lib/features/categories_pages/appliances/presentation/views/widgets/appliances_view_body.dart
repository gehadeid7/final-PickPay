import 'package:flutter/material.dart';
import 'package:pickpay/core/widgets/build_appbar.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
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
import 'package:pickpay/features/categories_pages/widgets/brand_filter_widget.dart';
import 'package:pickpay/features/categories_pages/widgets/price_range_filter.dart';
import 'package:pickpay/features/categories_pages/widgets/rating_filter.dart';
import 'package:pickpay/features/categories_pages/widgets/product_card.dart';
import 'package:pickpay/services/api_service.dart';

class AppliancesViewBody extends StatefulWidget {
  const AppliancesViewBody({super.key});

  @override
  State<AppliancesViewBody> createState() => _AppliancesViewBodyState();
}

class _AppliancesViewBodyState extends State<AppliancesViewBody> {
  String? _selectedBrand;
  double _minRating = 0;
  RangeValues _priceRange = const RangeValues(0, 10000);
  late Future<List<ProductsViewsModel>> _productsFuture;

  // Map of key phrases to detail pages with their static data
  static final Map<String, Map<String, dynamic>> productData = {
    'TORNADO': {
      'page': const AppliancesProduct12(),
      'rating': 4.5,
      'reviewCount': 12,
      'image': 'assets/appliances/product12/1.png',
      'brand': 'Tornado',
    },
    'Vacuum Cleaner': {
      'page': const AppliancesProduct10(),
      'rating': 4.6,
      'reviewCount': 4576,
      'image': 'assets/appliances/product10/1.png',
      'brand': 'Generic',
    },
    'Dough Mixer': {
      'page': const AppliancesProduct15(),
      'rating': 4.6,
      'reviewCount': 1735,
      'image': 'assets/appliances/product15/1.png',
      'brand': 'Generic',
    },
    'Blender': {
      'page': const AppliancesProduct13(),
      'rating': 4.9,
      'reviewCount': 1439,
      'image': 'assets/appliances/product13/1.png',
      'brand': 'Generic',
    },
    'Refrigerator': {
      'page': const AppliancesProduct3(),
      'rating': 4.5,
      'reviewCount': 12,
      'image': 'assets/appliances/product3/1.png',
      'brand': 'Generic',
    },
    'Air Fryer': {
      'page': const AppliancesProduct6(),
      'rating': 3.1,
      'reviewCount': 9,
      'image': 'assets/appliances/product6/1.png',
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
    'Coffee Maker': {
      'page': const AppliancesProduct7(),
      'rating': 3.1,
      'reviewCount': 1288,
      'image': 'assets/appliances/product7/1.png',
      'brand': 'Generic',
    },
    'Toaster': {
      'page': const AppliancesProduct8(),
      'rating': 4.6,
      'reviewCount': 884,
      'image': 'assets/appliances/product8/1.png',
      'brand': 'Generic',
    },
    'Iron': {
      'page': const AppliancesProduct9(),
      'rating': 4.8,
      'reviewCount': 1193,
      'image': 'assets/appliances/product9/1.png',
      'brand': 'Generic',
    },
    'fan': {
      'page': const AppliancesProduct11(),
      'rating': 4.4,
      'reviewCount': 674,
      'image': 'assets/appliances/product11/1.png',
      'brand': 'Generic',
    },
    'Kettle': {
      'page': const AppliancesProduct14(),
      'rating': 4.5,
      'reviewCount': 1162,
      'image': 'assets/appliances/product14/1.png',
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

      final priceMatch = product.price >= _priceRange.start &&
          product.price <= _priceRange.end;

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
      appBar: buildAppBar(context: context, title: 'Appliances'),
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

          final filteredProducts = _filterProducts(snapshot.data!);
          final maxPrice = snapshot.data!
              .map((product) => product.price)
              .reduce((a, b) => a > b ? a : b);

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
                    products: snapshot.data!,
                    selectedBrand: _selectedBrand,
                    onBrandChanged: (newBrand) {
                      setState(() {
                        _selectedBrand = newBrand;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 8),
                // Price and Rating filters in a row
                Row(
                  children: [
                    // Price Filter (left side)
                    Expanded(
                      child: Card(
                        elevation: 2,
                        child: PriceRangeFilterWidget(
                          values: _priceRange,
                          maxPrice: maxPrice,
                          onChanged: (range) =>
                              setState(() => _priceRange = range),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    // Rating Filter (right side)
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
