import 'package:flutter/material.dart';
import 'package:pickpay/core/widgets/build_appbar.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/products_views/electronics_products_views/product1.dart';
import 'package:pickpay/features/categories_pages/products_views/electronics_products_views/product10.dart';
import 'package:pickpay/features/categories_pages/products_views/electronics_products_views/product6.dart';
import 'package:pickpay/features/categories_pages/products_views/electronics_products_views/product7.dart';
import 'package:pickpay/features/categories_pages/products_views/electronics_products_views/product8.dart';
import 'package:pickpay/features/categories_pages/products_views/electronics_products_views/product9.dart';
import 'package:pickpay/features/categories_pages/widgets/brand_filter_widget.dart';
import 'package:pickpay/features/categories_pages/widgets/price_range_filter.dart';
import 'package:pickpay/features/categories_pages/widgets/rating_filter.dart';
import 'package:pickpay/features/categories_pages/widgets/product_card.dart';

class TVsPage extends StatefulWidget {
  const TVsPage({super.key});

  @override
  State<TVsPage> createState() => _TVsPage();
}

class _TVsPage extends State<TVsPage> {
  String? _selectedBrand;
  double _minRating = 0;
  late RangeValues _priceRange; // Changed to late initialization

  final List<ProductsViewsModel> _allProducts = [
    ProductsViewsModel(
      id: 'elec6',
      title:
          'Samsung 55 Inch QLED Smart TV Neural HDR Quantum Processor Lite 4K - QA55QE1DAUXEG [2024 Model]',
      price: 18499.00,
      originalPrice: 0,
      rating: 4.0,
      reviewCount: 19,
      brand: 'Samsung',
      imagePaths: ['assets/electronics_products/tvscreens/tv1/1.png'],
    ),
    ProductsViewsModel(
      id: 'elec7',
      title:
          'Xiaomi TV A 43 2025, 43", FHD, HDR, Smart Google TV with Dolby Atmos',
      price: 9999.00,
      originalPrice: 0,
      rating: 4.0,
      reviewCount: 19,
      brand: 'Xiaomi',
      imagePaths: ['assets/electronics_products/tvscreens/tv2/1.png'],
    ),
    ProductsViewsModel(
      id: 'elec8',
      title:
          'Samsung 50 Inch TV Crystal Processor 4K LED - Titan Gray - UA50DU8000UXEG [2024 Model]',
      price: 16299.00,
      originalPrice: 20999.00,
      rating: 4.0,
      reviewCount: 19,
      brand: 'Samsung',
      imagePaths: ['assets/electronics_products/tvscreens/tv3/1.png'],
    ),
    ProductsViewsModel(
      id: 'elec9',
      title:
          'SHARP 4K Smart Frameless TV 55 Inch Built-In Receiver 4T-C55FL6EX',
      price: 16999.00,
      originalPrice: 23499.00,
      rating: 4.0,
      reviewCount: 19,
      brand: 'SHARP',
      imagePaths: ['assets/electronics_products/tvscreens/tv4/1.png'],
    ),
    ProductsViewsModel(
      id: 'elec10',
      title:
          'LG UHD 4K TV 60 Inch UQ7900 Series, Cinema Screen Design WebOS Smart AI ThinQ',
      price: 18849.00,
      originalPrice: 23999.00,
      rating: 4.5,
      reviewCount: 19,
      brand: 'LG',
      imagePaths: ['assets/electronics_products/tvscreens/tv5/1.png'],
    ),
  ];
  @override
  void initState() {
    super.initState();
    // Initialize price range after products are available
    final maxPrice = _allProducts
        .map((product) => product.price)
        .reduce((a, b) => a > b ? a : b);
    _priceRange = RangeValues(0, maxPrice);
  }

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

    // Ensure current range values are within bounds
    final currentValues = RangeValues(
      _priceRange.start.clamp(0, maxPrice),
      _priceRange.end.clamp(0, maxPrice),
    );

    return Scaffold(
      appBar: buildAppBar(context: context, title: 'TVs'),
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
                    values: currentValues,
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
                    final productId = product.id;
                    Widget productDetailView;

                    switch (productId) {
                      case 'elec6':
                        productDetailView = const Product6View();
                        break;
                      case 'elec7':
                        productDetailView = const Product7View();
                        break;
                      case 'elec8':
                        productDetailView = const Product8View();
                        break;
                      case 'elec9':
                        productDetailView = const Product9View();
                        break;
                      case 'elec10':
                        productDetailView = const Product10View();
                        break;

                      default:
                        productDetailView = const Product1View();
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
