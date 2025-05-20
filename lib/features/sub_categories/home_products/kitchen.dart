import 'package:flutter/material.dart';
import 'package:pickpay/core/widgets/build_appbar.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/products_views/home_products/home_product1.dart';
import 'package:pickpay/features/categories_pages/products_views/home_products/home_product11.dart';
import 'package:pickpay/features/categories_pages/products_views/home_products/home_product12.dart';
import 'package:pickpay/features/categories_pages/products_views/home_products/home_product13.dart';
import 'package:pickpay/features/categories_pages/products_views/home_products/home_product14.dart';
import 'package:pickpay/features/categories_pages/products_views/home_products/home_product15.dart';
import 'package:pickpay/features/categories_pages/widgets/brand_filter_widget.dart';
import 'package:pickpay/features/categories_pages/widgets/price_range_filter.dart';
import 'package:pickpay/features/categories_pages/widgets/rating_filter.dart';
import 'package:pickpay/features/categories_pages/widgets/product_card.dart';

class Kitchenview extends StatefulWidget {
  const Kitchenview({super.key});

  @override
  State<Kitchenview> createState() => _Kitchenview();
}

class _Kitchenview extends State<Kitchenview> {
  String? _selectedBrand;
  double _minRating = 0;
  RangeValues? _priceRange;

  final List<ProductsViewsModel> _allProducts = [
    ProductsViewsModel(
      id: 'home11',
      title: 'Neoflam Pote Cookware Set 11-Pieces, Pink Marble',
      price: 15795.00,
      originalPrice: 18989.00,
      rating: 4.8,
      reviewCount: 19,
      brand: 'Neoflam',
      imagePaths: ['assets/Home_products/kitchen/kitchen1/1.png'],
    ),
    ProductsViewsModel(
      id: 'home12',
      title: 'Pasabahce Set of 6 Large Mug with Handle -340ml Turkey Made',
      price: 495.00,
      originalPrice: 590.99,
      rating: 4.9,
      reviewCount: 1439,
      brand: 'Pasabahce',
      imagePaths: ['assets/Home_products/kitchen/kitchen2/1.png'],
    ),
    ProductsViewsModel(
      id: 'home13',
      title:
          'P&P CHEF 13½ Inch Pizza Pan Set, 3 Pack Nonstick Pizza Pans, Round Pizza Tray Bakeware for Oven Baking',
      price: 276.00,
      originalPrice: 300.00,
      rating: 4.5,
      reviewCount: 1162,
      brand: 'P&P CHEF',
      imagePaths: ['assets/Home_products/kitchen/kitchen3/1.png'],
    ),
    ProductsViewsModel(
      id: 'home14',
      title:
          'LIANYU 20 Piece Silverware Flatware Cutlery Set, Stainless Steel Utensils Service for 4',
      price: 50099.00,
      originalPrice: 69990.00,
      rating: 4.6,
      reviewCount: 1735,
      brand: 'LIANYU',
      imagePaths: ['assets/Home_products/kitchen/kitchen4/1.png'],
    ),
    ProductsViewsModel(
      id: 'home15',
      title:
          'Dish Rack Dish Drying Stand Dish Drainer Plate Rack Dish rake Kitchen Organizer',
      price: 400.00,
      originalPrice: 550.99,
      rating: 4.6,
      reviewCount: 4576,
      brand: 'Generic',
      imagePaths: ['assets/Home_products/kitchen/kitchen5/1.png'],
    ),
  ];

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

  @override
  void initState() {
    super.initState();
    final maxPrice = _allProducts
        .map((product) => product.price)
        .reduce((a, b) => a > b ? a : b);
    _priceRange = RangeValues(0, maxPrice);
  }

  @override
  Widget build(BuildContext context) {
    final maxPrice = _allProducts
        .map((product) => product.price)
        .reduce((a, b) => a > b ? a : b);

    final filteredProducts = _filterProducts(_allProducts);

    return Scaffold(
      appBar: buildAppBar(context: context, title: 'Kitchen & Dining'),
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

          // Price and Rating filters
          Row(
            children: [
              Expanded(
                child: Card(
                  elevation: 2,
                  child: PriceRangeFilterWidget(
                    values: _priceRange!, // crash if _priceRange is null
                    maxPrice: maxPrice,
                    onChanged: (range) => setState(() => _priceRange = range),
                  ),
                ),
              ),
              const SizedBox(width: 8),
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

          // Product list
          ...filteredProducts.map((product) {
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
                    Widget productDetailView;
                    switch (product.id) {
                      case 'home11':
                        productDetailView = const HomeProduct11();
                        break;
                      case 'home12':
                        productDetailView = const HomeProduct12();
                        break;
                      case 'home13':
                        productDetailView = const HomeProduct13();
                        break;
                      case 'home14':
                        productDetailView = const HomeProduct14();
                        break;
                      case 'home15':
                        productDetailView = const HomeProduct15();
                        break;
                      default:
                        productDetailView = const HomeProduct1();
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
          }).toList(),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
