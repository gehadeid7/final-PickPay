import 'package:flutter/material.dart';
import 'package:pickpay/core/widgets/build_appbar.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/products_views/home_products/home_product1.dart';
import 'package:pickpay/features/categories_pages/products_views/home_products/home_product2.dart';
import 'package:pickpay/features/categories_pages/products_views/home_products/home_product3.dart';
import 'package:pickpay/features/categories_pages/products_views/home_products/home_product4.dart';
import 'package:pickpay/features/categories_pages/products_views/home_products/home_product5.dart';
import 'package:pickpay/features/categories_pages/widgets/brand_filter_widget.dart';
import 'package:pickpay/features/categories_pages/widgets/price_range_filter.dart';
import 'package:pickpay/features/categories_pages/widgets/rating_filter.dart';
import 'package:pickpay/features/categories_pages/widgets/product_card.dart';

class FurnitureView extends StatefulWidget {
  const FurnitureView({super.key});

  @override
  State<FurnitureView> createState() => _FurnitureView();
}

class _FurnitureView extends State<FurnitureView> {
  String? _selectedBrand;
  double _minRating = 0;
  RangeValues _priceRange = const RangeValues(0, 10000);

  final List<ProductsViewsModel> _allProducts = [
    ProductsViewsModel(
      id: 'home1',
      title: 'Golden Life Sofa Bed - Size 190 cm - Beige',
      price: 7850.00,
      originalPrice: 0,
      rating: 5.0,
      reviewCount: 88,
      brand: 'Golden Life',
      imagePaths: ['assets/Home_products/furniture/furniture1/1.png'],
    ),
    ProductsViewsModel(
      id: 'home2',
      title: 'Star Bags Bean Bag Chair - Purple, 95*95*97 cm, Unisex Adults',
      price: 1699.00,
      originalPrice: 2499.00,
      rating: 5.0,
      reviewCount: 88,
      brand: 'Star Bags',
      imagePaths: ['assets/Home_products/furniture/furniture2/1.png'],
    ),
    ProductsViewsModel(
      id: 'home3',
      title: 'Generic Coffee Table, Round, 71 cm x 45 cm, Black',
      price: 3600.00,
      originalPrice: 0,
      rating: 5.0,
      reviewCount: 88,
      brand: 'Generic',
      imagePaths: ['assets/Home_products/furniture/furniture3/1.png'],
    ),
    ProductsViewsModel(
      id: 'home4',
      title: 'Gaming Chair, Furgle Gocker Ergonomic Adjustable 3D Swivel Chair',
      price: 9696.55,
      originalPrice: 12071.00,
      rating: 5.0,
      reviewCount: 92,
      brand: 'Furgle',
      imagePaths: ['assets/Home_products/furniture/furniture4/1.png'],
    ),
    ProductsViewsModel(
      id: 'home5',
      title: 'Janssen Almany Innerspring Mattress Height 25 cm - 120 x 195 cm',
      price: 5060.03,
      originalPrice: 0,
      rating: 5.0,
      reviewCount: 88,
      brand: 'Janssen',
      imagePaths: ['assets/Home_products/furniture/furniture5/1.png'],
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
      appBar: buildAppBar(context: context, title: 'Furniture'),
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
                      case 'home1':
                        productDetailView = const HomeProduct1();
                        break;
                      case 'home2':
                        productDetailView = const HomeProduct2();
                        break;
                      case 'home3':
                        productDetailView = const HomeProduct3();
                        break;
                      case 'home4':
                        productDetailView = const HomeProduct4();
                        break;
                      case 'home5':
                        productDetailView = const HomeProduct5();
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
