import 'package:flutter/material.dart';
import 'package:pickpay/core/widgets/build_appbar.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/products_views/fashion_products_views/fashion_product1.dart';
import 'package:pickpay/features/categories_pages/products_views/fashion_products_views/fashion_product11.dart';
import 'package:pickpay/features/categories_pages/products_views/fashion_products_views/fashion_product12.dart';
import 'package:pickpay/features/categories_pages/products_views/fashion_products_views/fashion_product13.dart';
import 'package:pickpay/features/categories_pages/products_views/fashion_products_views/fashion_product14.dart';
import 'package:pickpay/features/categories_pages/products_views/fashion_products_views/fashion_product15.dart';
import 'package:pickpay/features/categories_pages/widgets/brand_filter_widget.dart';
import 'package:pickpay/features/categories_pages/widgets/price_range_filter.dart';
import 'package:pickpay/features/categories_pages/widgets/product_card.dart';
import 'package:pickpay/features/categories_pages/widgets/rating_filter.dart';

class Kids extends StatefulWidget {
  const Kids({super.key});

  @override
  State<Kids> createState() => _Kids();
}

class _Kids extends State<Kids> {
  String? _selectedBrand;
  double _minRating = 0;
  RangeValues _priceRange = const RangeValues(0, 900); // Initial safe value

  final List<ProductsViewsModel> _allProducts = [
    ProductsViewsModel(
      id: '68132a95ff7813b3d47f9da11',
      title: "LC WAIKIKI Crew Neck Girl's Shorts Pajama Set",
      price: 261.00,
      originalPrice: 349.00,
      rating: 4.3,
      reviewCount: 11,
      brand: 'LC WAIKIKI',
      imagePaths: ["assets/Fashion_products/Kids_Fashion/kids_fashion1/1.png"],
    ),
    ProductsViewsModel(
      id: '68132a95ff7813b3d47f9da12',
      title: "Kidzo Boys Pajamas",
      price: 580.00,
      originalPrice: 621.00,
      rating: 5.0,
      reviewCount: 3,
      brand: 'Kidzo',
      imagePaths: ["assets/Fashion_products/Kids_Fashion/kids_fashion2/1.png"],
    ),
    ProductsViewsModel(
      id: '68132a95ff7813b3d47f9da13',
      title: "DeFacto Girls Cropped Fit Long Sleeve B9857A8 Denim Jacket",
      price: 899.00,
      originalPrice: 899.00,
      rating: 4.0,
      reviewCount: 19,
      brand: 'DeFacto',
      imagePaths: ["assets/Fashion_products/Kids_Fashion/kids_fashion3/1.png"],
    ),
    ProductsViewsModel(
      id: '68132a95ff7813b3d47f9da14',
      title:
          "Baby Boys Jacket Fashion Comfortable High Quality Plush Full Warmth Jacket for Your Baby",
      price: 425.00,
      originalPrice: 475.00,
      rating: 5.0,
      reviewCount: 19,
      brand: 'Generic',
      imagePaths: ["assets/Fashion_products/Kids_Fashion/kids_fashion4/1.png"],
    ),
    ProductsViewsModel(
      id: '68132a95ff7813b3d47f9da15',
      title: "MIX & MAX, Ballerina Shoes, girls, Ballet Flat",
      price: 354.65,
      originalPrice: 429.00,
      rating: 5.0,
      reviewCount: 19,
      brand: 'MIX & MAX',
      imagePaths: ["assets/Fashion_products/Kids_Fashion/kids_fashion5/1.png"],
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
      appBar: buildAppBar(context: context, title: "Kids' Fashion"),
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
                      case '68132a95ff7813b3d47f9da11':
                        productDetailView = const FashionProduct11();
                        break;
                      case '68132a95ff7813b3d47f9da12':
                        productDetailView = const FashionProduct12();
                        break;
                      case '68132a95ff7813b3d47f9da13':
                        productDetailView = const FashionProduct13();
                        break;
                      case '68132a95ff7813b3d47f9da14':
                        productDetailView = const FashionProduct14();
                        break;
                      case '68132a95ff7813b3d47f9da15':
                        productDetailView = const FashionProduct15();
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
