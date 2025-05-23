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
  RangeValues? _priceRange;
  late Future<List<ProductsViewsModel>> _productsFuture;

  // Map of key phrases to detail pages with their static data
  static final Map<String, Map<String, dynamic>> productData = {
    '68252918a68b49cb0616420f': {
      'page': const AppliancesProduct12(),
      'rating': 4.5,
      'reviewCount': 12,
      'image': 'assets/appliances/product12/1.png',
      'brand': 'Tornado',
    },
    '68252918a68b49cb0616420d': {
      'page': const AppliancesProduct10(),
      'rating': 4.6,
      'reviewCount': 4576,
      'image': 'assets/appliances/product10/1.png',
      'brand': 'Generic',
    },
    '68252918a68b49cb06164212': {
      'page': const AppliancesProduct15(),
      'rating': 4.6,
      'reviewCount': 1735,
      'image': 'assets/appliances/product15/1.png',
      'brand': 'Generic',
    },
    '68252918a68b49cb06164210': {
      'page': const AppliancesProduct13(),
      'rating': 4.9,
      'reviewCount': 1439,
      'image': 'assets/appliances/product13/1.png',
      'brand': 'Generic',
    },
    '68252918a68b49cb06164206': {
      'page': const AppliancesProduct3(),
      'rating': 4.5,
      'reviewCount': 12,
      'image': 'assets/appliances/product3/1.png',
      'brand': 'Generic',
    },
    '68252918a68b49cb06164209': {
      'page': const AppliancesProduct6(),
      'rating': 3.1,
      'reviewCount': 9,
      'image': 'assets/appliances/product6/1.png',
      'brand': 'Generic',
    },
    '68252918a68b49cb06164204': {
      'page': const AppliancesProduct1(),
      'rating': 3.9,
      'reviewCount': 9,
      'image': 'assets/appliances/product1/1.png',
      'brand': 'Generic',
    },
    '68252918a68b49cb06164205': {
      'page': const AppliancesProduct2(),
      'rating': 3.1,
      'reviewCount': 9,
      'image': 'assets/appliances/product2/1.png',
      'brand': 'Generic',
    },
    '68252918a68b49cb06164207': {
      'page': const AppliancesProduct4(),
      'rating': 4.2,
      'reviewCount': 14,
      'image': 'assets/appliances/product4/1.png',
      'brand': 'Generic',
    },
    '68252918a68b49cb06164208': {
      'page': const AppliancesProduct5(),
      'rating': 4.0,
      'reviewCount': 11,
      'image': 'assets/appliances/product5/1.png',
      'brand': 'Generic',
    },
    '68252918a68b49cb0616420a': {
      'page': const AppliancesProduct7(),
      'rating': 3.1,
      'reviewCount': 1288,
      'image': 'assets/appliances/product7/1.png',
      'brand': 'Generic',
    },
    '68252918a68b49cb0616420b': {
      'page': const AppliancesProduct8(),
      'rating': 4.6,
      'reviewCount': 884,
      'image': 'assets/appliances/product8/1.png',
      'brand': 'Generic',
    },
    '68252918a68b49cb0616420c': {
      'page': const AppliancesProduct9(),
      'rating': 4.8,
      'reviewCount': 1193,
      'image': 'assets/appliances/product9/1.png',
      'brand': 'Generic',
    },
    '68252918a68b49cb0616420e': {
      'page': const AppliancesProduct11(),
      'rating': 4.4,
      'reviewCount': 674,
      'image': 'assets/appliances/product11/1.png',
      'brand': 'Generic',
    },
    '68252918a68b49cb06164211': {
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

    for (var p in apiProducts) {
      print('API Product ID: ${p.id}');
    }

    return apiProducts.map((apiProduct) {
      final matchingKey =
          productData.containsKey(apiProduct.id) ? apiProduct.id : '';
      print('Matching key for ${apiProduct.id} -> $matchingKey');

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

  Widget? _findDetailPageById(String productId) {
    if (productData.containsKey(productId)) {
      return productData[productId]!['page'] as Widget;
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
          _priceRange ??= RangeValues(0, maxPrice);

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
                // Price and Rating filters in a row
                Row(
                  children: [
                    // Price Filter (left side)
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
                  final productPage = _findDetailPageById(product.id);
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
                  // ignore: unnecessary_to_list_in_spreads
                }).toList(),
              ],
            ),
          );
        },
      ),
    );
  }
}
