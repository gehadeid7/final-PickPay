import 'package:flutter/material.dart';
import 'package:pickpay/core/widgets/build_appbar.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/products_views/electronics_products_views/product1.dart';
import 'package:pickpay/features/categories_pages/products_views/electronics_products_views/product10.dart';
import 'package:pickpay/features/categories_pages/products_views/electronics_products_views/product11.dart';
import 'package:pickpay/features/categories_pages/products_views/electronics_products_views/product12.dart';
import 'package:pickpay/features/categories_pages/products_views/electronics_products_views/product13.dart';
import 'package:pickpay/features/categories_pages/products_views/electronics_products_views/product14.dart';
import 'package:pickpay/features/categories_pages/products_views/electronics_products_views/product15.dart';
import 'package:pickpay/features/categories_pages/products_views/electronics_products_views/product2.dart';
import 'package:pickpay/features/categories_pages/products_views/electronics_products_views/product3.dart';
import 'package:pickpay/features/categories_pages/products_views/electronics_products_views/product4.dart';
import 'package:pickpay/features/categories_pages/products_views/electronics_products_views/product5.dart';
import 'package:pickpay/features/categories_pages/products_views/electronics_products_views/product6.dart';
import 'package:pickpay/features/categories_pages/products_views/electronics_products_views/product7.dart';
import 'package:pickpay/features/categories_pages/products_views/electronics_products_views/product8.dart';
import 'package:pickpay/features/categories_pages/products_views/electronics_products_views/product9.dart';
import 'package:pickpay/features/categories_pages/widgets/brand_filter_widget.dart';
import 'package:pickpay/features/categories_pages/widgets/price_range_filter.dart';
import 'package:pickpay/features/categories_pages/widgets/rating_filter.dart';
import 'package:pickpay/features/categories_pages/widgets/product_card.dart';
import 'package:pickpay/services/api_service.dart';

class ElectronicsViewBody extends StatefulWidget {
  const ElectronicsViewBody({super.key});

  @override
  State<ElectronicsViewBody> createState() => _ElectronicsViewBodyState();
}

class _ElectronicsViewBodyState extends State<ElectronicsViewBody> {
  String? _selectedBrand;
  double _minRating = 0;
  RangeValues? _priceRange;
  late Future<List<ProductsViewsModel>> _productsFuture;

  static final Map<String, Map<String, dynamic>> productData = {
    '6819e22b123a4faad16613be': {
      'page': const Product1View(),
      'rating': 3.1,
      'reviewCount': 9,
      'image':
          'assets/electronics_products/mobile_and_tablet/mobile_and_tablet1/1.png',
      'brand': 'Samsung',
    },
    '6819e22b123a4faad16613bf': {
      'page': const Product2View(),
      'rating': 4.7,
      'reviewCount': 2019,
      'image':
          'assets/electronics_products/mobile_and_tablet/mobile_and_tablet2/1.png',
      'brand': 'Sony',
    },
    '6819e22b123a4faad16613c0': {
      'page': const Product3View(),
      'rating': 4.3,
      'reviewCount': 321,
      'image': 'assets/electronics_products/mobile_and_tablet/mobile_and_tablet3/1.png',
      'brand': 'LG',
    },
    '6819e22b123a4faad16613c1': {
      'page': const Product4View(),
      'rating': 4.2,
      'reviewCount': 178,
      'image': 'assets/electronics_products/mobile_and_tablet/mobile_and_tablet4/1.png',
      'brand': 'Panasonic',
    },
    '6819e22b123a4faad16613c3': {
      'page': const Product5View(),
      'rating': 4.9,
      'reviewCount': 543,
      'image': 'assets/electronics_products/mobile_and_tablet/mobile_and_tablet5/1.png',
      'brand': 'Apple',
    },
    '6819e22b123a4faad16613c4': {
      'page': const Product6View(),
      'rating': 4.9,
      'reviewCount': 543,
      'image': 'assets/electronics_products/tvscreens/tv1/1.png',
      'brand': 'Apple',
    },
    '6819e22b123a4faad16613c5': {
      'page': const Product7View(),
      'rating': 4.9,
      'reviewCount': 543,
      'image': 'assets/electronics_products/tvscreens/tv2/1.png',
      'brand': 'Apple',
    },
    '6819e22b123a4faad16613c6': {
      'page': const Product8View(),
      'rating': 4.9,
      'reviewCount': 543,
      'image': 'assets/electronics_products/tvscreens/tv3/1.png',
      'brand': 'Apple',
    },
    '6819e22b123a4faad16613c7': {
      'page': const Product9View(),
      'rating': 4.9,
      'reviewCount': 543,
      'image': 'assets/electronics_products/tvscreens/tv4/1.png',
      'brand': 'Apple',
    },
    '6819e22b123a4faad16613c8': {
      'page': const Product10View(),
      'rating': 4.9,
      'reviewCount': 543,
      'image': 'assets/electronics_products/tvscreens/tv5/1.png',
      'brand': 'Apple',
    },
    '6819e22b123a4faad16613c9': {
      'page': const Product11View(),
      'rating': 4.9,
      'reviewCount': 543,
      'image': 'assets/electronics_products/Laptop/Laptop1/1.png',
      'brand': 'Apple',
    },
    '6819e22b123a4faad16613ca': {
      'page': const Product12View(),
      'rating': 4.9,
      'reviewCount': 543,
      'image': 'assets/electronics_products/Laptop/Laptop2/1.png',
      'brand': 'Apple',
    },
    '6819e22b123a4faad16613cb': {
      'page': const Product13View(),
      'rating': 4.9,
      'reviewCount': 543,
      'image': 'assets/electronics_products/Laptop/Laptop3/1.png',
      'brand': 'Apple',
    },
    '6819e22b123a4faad16613cc': {
      'page': const Product14View(),
      'rating': 4.9,
      'reviewCount': 543,
      'image': 'assets/electronics_products/Laptop/Laptop4/1.png',
      'brand': 'Apple',
    },
    '6819e22b123a4faad16613c2': {
      'page': const Product15View(),
      'rating': 4.9,
      'reviewCount': 543,
      'image': 'assets/electronics_products/Laptop/Laptop5/1.png',
      'brand': 'Apple',
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
      final matchingKey =
          productData.containsKey(apiProduct.id) ? apiProduct.id : '';
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
      appBar: buildAppBar(context: context, title: 'Electronics'),
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
                'No electronics available at the moment.',
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
                }).toList(),
              ],
            ),
          );
        },
      ),
    );
  }
}
