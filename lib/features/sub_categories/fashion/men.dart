import 'package:flutter/material.dart';
import 'package:pickpay/core/widgets/build_appbar.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/products_views/fashion_products_views/fashion_product1.dart';
import 'package:pickpay/features/categories_pages/products_views/fashion_products_views/fashion_product10.dart';
import 'package:pickpay/features/categories_pages/products_views/fashion_products_views/fashion_product6.dart';
import 'package:pickpay/features/categories_pages/products_views/fashion_products_views/fashion_product7.dart';
import 'package:pickpay/features/categories_pages/products_views/fashion_products_views/fashion_product8.dart';
import 'package:pickpay/features/categories_pages/products_views/fashion_products_views/fashion_product9.dart';
import 'package:pickpay/features/categories_pages/widgets/brand_filter_widget.dart';
import 'package:pickpay/features/categories_pages/widgets/price_range_filter.dart';
import 'package:pickpay/features/categories_pages/widgets/product_card.dart';
import 'package:pickpay/features/categories_pages/widgets/rating_filter.dart';

class Men extends StatefulWidget {
  const Men({super.key});

  @override
  State<Men> createState() => _Men();
}

class _Men extends State<Men> {
  String? _selectedBrand;
  double _minRating = 0;
  RangeValues _priceRange = const RangeValues(0, 900); // Initial safe value

  final List<ProductsViewsModel> _allProducts = [
    ProductsViewsModel(
      id: '68132a95ff7813b3d47f9da6',
      title:
          "DeFacto Man Modern Fit Polo Neck Short Sleeve B6374AX Polo T-Shirt",
      price: 352.00,
      originalPrice: 899.00,
      rating: 4.0,
      reviewCount: 19,
      brand: 'DeFacto',
      imagePaths: ["assets/Fashion_products/Men_Fashion/men_fashion1/1.png"],
    ),
    ProductsViewsModel(
      id: '68132a95ff7813b3d47f9da7',
      title: "DOTT JEANS WEAR Men's Relaxed Fit Jeans",
      price: 718.30,
      originalPrice: 799.00,
      rating: 4.0,
      reviewCount: 19,
      brand: 'DOTT',
      imagePaths: ["assets/Fashion_products/Men_Fashion/men_fashion2/1.png"],
    ),
    ProductsViewsModel(
      id: '68132a95ff7813b3d47f9da8',
      title:
          "Sport-Q®Fury-X Latest Model Football Shoes X Football Shoes Combining Comfort Precision and Performance Excellence in Game.",
      price: 269.00,
      originalPrice: 299.00,
      rating: 4.0,
      reviewCount: 19,
      brand: 'Sport-Q',
      imagePaths: ["assets/Fashion_products/Men_Fashion/men_fashion3/1.png"],
    ),
    ProductsViewsModel(
      id: '68132a95ff7813b3d47f9da9',
      title: "Timberland Ek Larchmont Ftm_Chelsea, Men's Boots",
      price: 10499.00,
      originalPrice: 11000.00,
      rating: 4.3,
      reviewCount: 57,
      brand: 'Timberland',
      imagePaths: ["assets/Fashion_products/Men_Fashion/men_fashion4/1.png"],
    ),
    ProductsViewsModel(
      id: '68132a95ff7813b3d47f9da10',
      title:
          "Timberland Men's Leather Trifold Wallet Hybrid, Brown/Black, One Size",
      price: 1399.00,
      originalPrice: 1511.00,
      rating: 4.6,
      reviewCount: 1118,
      brand: 'Timberland',
      imagePaths: ["assets/Fashion_products/Men_Fashion/men_fashion5/1.png"],
    ),
  ];
  @override
  void initState() {
    super.initState();
    // Update price range after widget is initialized
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final maxPrice = _allProducts
          .map((product) => product.price)
          .reduce((a, b) => a > b ? a : b);
      setState(() {
        _priceRange = RangeValues(0, maxPrice);
      });
    });
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
      appBar: buildAppBar(context: context, title: "Men's Fashion"),
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
                    onChanged: (range) {
                      setState(() {
                        _priceRange = range;
                      });
                    },
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
                      case '68132a95ff7813b3d47f9da6':
                        productDetailView = const FashionProduct6();
                        break;
                      case '68132a95ff7813b3d47f9da7':
                        productDetailView = const FashionProduct7();
                        break;
                      case '68132a95ff7813b3d47f9da8':
                        productDetailView = const FashionProduct8();
                        break;
                      case '68132a95ff7813b3d47f9da9':
                        productDetailView = const FashionProduct9();
                        break;
                      case '68132a95ff7813b3d47f9da10':
                        productDetailView = const FashionProduct10();
                        break;

                      default:
                        productDetailView = const FashionProduct1();
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
