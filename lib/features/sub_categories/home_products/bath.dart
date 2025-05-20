import 'package:flutter/material.dart';
import 'package:pickpay/core/widgets/build_appbar.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/products_views/home_products/home_product1.dart';
import 'package:pickpay/features/categories_pages/products_views/home_products/home_product16.dart';
import 'package:pickpay/features/categories_pages/products_views/home_products/home_product17.dart';
import 'package:pickpay/features/categories_pages/products_views/home_products/home_product18.dart';
import 'package:pickpay/features/categories_pages/products_views/home_products/home_product19.dart';
import 'package:pickpay/features/categories_pages/products_views/home_products/home_product20.dart';
import 'package:pickpay/features/categories_pages/widgets/brand_filter_widget.dart';
import 'package:pickpay/features/categories_pages/widgets/price_range_filter.dart';
import 'package:pickpay/features/categories_pages/widgets/rating_filter.dart';
import 'package:pickpay/features/categories_pages/widgets/product_card.dart';

class BathView extends StatefulWidget {
  const BathView({super.key});

  @override
  State<BathView> createState() => _BathViewState();
}

class _BathViewState extends State<BathView> {
  String? _selectedBrand;
  double _minRating = 0;
  RangeValues _priceRange = const RangeValues(0, 10000);

  final List<ProductsViewsModel> _allProducts = [
    ProductsViewsModel(
      id: 'home16',
      title: 'Banotex Cotton Towel 50x100 (Sugar)',
      price: 170.00,
      originalPrice: 200.99,
      rating: 4.6,
      reviewCount: 4576,
      brand: 'Banotex',
      imagePaths: ['assets/Home_products/bath_and_bedding/bath1/1.png'],
    ),
    ProductsViewsModel(
      id: 'home17',
      title: 'Fiber pillow 2 pieces size 40x60',
      price: 180.00,
      originalPrice: 200.99,
      rating: 4.6,
      reviewCount: 4576,
      brand: 'Generic',
      imagePaths: ['assets/Home_products/bath_and_bedding/bath2/1.png'],
    ),
    ProductsViewsModel(
      id: 'home18',
      title:
          'Bedsure 100% Cotton Blankets Queen Size for Bed - Waffle Weave Blankets for Summer',
      price: 604.00,
      originalPrice: 700.99,
      rating: 4.6,
      reviewCount: 4576,
      brand: 'Bedsure',
      imagePaths: ['assets/Home_products/bath_and_bedding/bath3/1.png'],
    ),
    ProductsViewsModel(
      id: 'home19',
      title: 'Home of linen-fitted sheet set, size 120 * 200cm, offwhite',
      price: 369.00,
      originalPrice: 400.99,
      rating: 4.6,
      reviewCount: 4576,
      brand: 'Home of linen',
      imagePaths: ['assets/Home_products/bath_and_bedding/bath4/1.png'],
    ),
    ProductsViewsModel(
      id: 'home20',
      title:
          'Home of Linen - Duvet Cover Set - 3 Pieces for Double Bed - 1 Duvet Cover (185cm*235cm) + 2 Pillow Cases',
      price: 948.00,
      originalPrice: 1000.99,
      rating: 4.6,
      reviewCount: 4576,
      brand: 'Home of Linen',
      imagePaths: ['assets/Home_products/bath_and_bedding/bath5/1.png'],
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
      appBar: buildAppBar(context: context, title: 'Bath & Bedding'),
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
                      case 'home16':
                        productDetailView = const HomeProduct16();
                        break;
                      case 'home17':
                        productDetailView = const HomeProduct17();
                        break;
                      case 'home18':
                        productDetailView = const HomeProduct18();
                        break;
                      case 'home19':
                        productDetailView = const HomeProduct19();
                        break;
                      case 'home20':
                        productDetailView = const HomeProduct20();
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
