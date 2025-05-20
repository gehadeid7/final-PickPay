import 'package:flutter/material.dart';
import 'package:pickpay/core/widgets/build_appbar.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/products_views/home_products/home_product1.dart';
import 'package:pickpay/features/categories_pages/products_views/home_products/home_product10.dart';
import 'package:pickpay/features/categories_pages/products_views/home_products/home_product6.dart';
import 'package:pickpay/features/categories_pages/products_views/home_products/home_product7.dart';
import 'package:pickpay/features/categories_pages/products_views/home_products/home_product8.dart';
import 'package:pickpay/features/categories_pages/products_views/home_products/home_product9.dart';
import 'package:pickpay/features/categories_pages/widgets/brand_filter_widget.dart';
import 'package:pickpay/features/categories_pages/widgets/price_range_filter.dart';
import 'package:pickpay/features/categories_pages/widgets/rating_filter.dart';
import 'package:pickpay/features/categories_pages/widgets/product_card.dart';

class HomeDecorview extends StatefulWidget {
  const HomeDecorview({super.key});

  @override
  State<HomeDecorview> createState() => _HomeDecorview();
}

class _HomeDecorview extends State<HomeDecorview> {
  String? _selectedBrand;
  double _minRating = 0;
  RangeValues _priceRange = const RangeValues(0, 10000);

  final List<ProductsViewsModel> _allProducts = [
    ProductsViewsModel(
      id: 'home6',
      title: 'Golden Lighting LED Gold Lampshade + 1 Crystal Cylinder Bulb.',
      price: 1128.00,
      originalPrice: 0.0,
      rating: 4.0,
      reviewCount: 19,
      brand: 'Golden Lighting',
      imagePaths: ['assets/Home_products/home-decor/home_decor1/1.png'],
    ),
    ProductsViewsModel(
      id: 'home7',
      title:
          'Luxury Bathroom Rug Shaggy Bath Mat 60x40 Cm, Washable Non Slip, Soft Chenille, Gray',
      price: 355.00,
      originalPrice: 0.0,
      rating: 4.0,
      reviewCount: 19,
      brand: 'Luxury',
      imagePaths: ['assets/Home_products/home-decor/home_decor2/1.png'],
    ),
    ProductsViewsModel(
      id: 'home8',
      title: 'Glass Vase 15cm',
      price: 250.00,
      originalPrice: 0.0,
      rating: 4.0,
      reviewCount: 19,
      brand: 'Generic',
      imagePaths: ['assets/Home_products/home-decor/home_decor3/1.png'],
    ),
    ProductsViewsModel(
      id: 'home9',
      title:
          'Amotpo Indoor/Outdoor Wall Clock, 12-Inch Waterproof with Thermometer & Hygrometer',
      price: 549.00,
      originalPrice: 0.0,
      rating: 4.0,
      reviewCount: 19,
      brand: 'Amotpo',
      imagePaths: ['assets/Home_products/home-decor/home_decor4/1.png'],
    ),
    ProductsViewsModel(
      id: 'home10',
      title:
          'Oliruim Black Home Decor Accent Art Woman Face Statue - 2 Pieces Set',
      price: 650.00,
      originalPrice: 0.0,
      rating: 5.0,
      reviewCount: 19,
      brand: 'Oliruim',
      imagePaths: ['assets/Home_products/home-decor/home_decor5/1.png'],
    ),
  ];

  List<ProductsViewsModel> get _filteredProducts {
    return _allProducts.where((product) {
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

  @override
  Widget build(BuildContext context) {
    final maxPrice = _allProducts
        .map((product) => product.price)
        .reduce((a, b) => a > b ? a : b);

    return Scaffold(
      appBar: buildAppBar(context: context, title: 'Home Decor'),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          // Filters section
          Card(
            elevation: 2,
            child: BrandFilterWidget(
              products: _allProducts,
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
                    values: _priceRange,
                    maxPrice: maxPrice,
                    onChanged: (range) => setState(() => _priceRange = range),
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
                    onChanged: (rating) => setState(() => _minRating = rating),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Products list
          ..._filteredProducts.map((product) {
            return Column(
              children: [
                ProductCard(
                  id: product.id,
                  name: product.title,
                  imagePaths: product.imagePaths ?? [],
                  price: product.price,
                  originalPrice: product.originalPrice ?? 0,
                  rating: product.rating ?? 0,
                  reviewCount: product.reviewCount ?? 0,
                  onTap: () {
                    // Navigate to the appropriate product detail view
                    // based on the product ID
                    final productId = product.id;
                    Widget productDetailView;

                    switch (productId) {
                      case 'home6':
                        productDetailView = const HomeProduct6();
                        break;
                      case 'home7':
                        productDetailView = const HomeProduct7();
                        break;
                      case 'home8':
                        productDetailView = const HomeProduct8();
                        break;
                      case 'home9':
                        productDetailView = const HomeProduct9();
                        break;
                      case 'home10':
                        productDetailView = const HomeProduct10();
                        break;

                      default:
                        productDetailView =
                            const HomeProduct1(); // Default fallback
                    }

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => productDetailView),
                    );
                  },
                ),
                const SizedBox(height: 10),
              ],
            );
            // ignore: unnecessary_to_list_in_spreads
          }).toList(),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
