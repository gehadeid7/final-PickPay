import 'package:flutter/material.dart';
import 'package:pickpay/core/widgets/build_appbar.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/products_views/beauty_products_views/beauty_product1.dart';
import 'package:pickpay/features/categories_pages/products_views/beauty_products_views/beauty_product11.dart';
import 'package:pickpay/features/categories_pages/products_views/beauty_products_views/beauty_product12.dart';
import 'package:pickpay/features/categories_pages/products_views/beauty_products_views/beauty_product13.dart';
import 'package:pickpay/features/categories_pages/products_views/beauty_products_views/beauty_product14.dart';
import 'package:pickpay/features/categories_pages/products_views/beauty_products_views/beauty_product15.dart';
import 'package:pickpay/features/categories_pages/widgets/brand_filter_widget.dart';
import 'package:pickpay/features/categories_pages/widgets/product_card.dart';
import 'package:pickpay/features/categories_pages/widgets/price_range_filter.dart';
import 'package:pickpay/features/categories_pages/widgets/rating_filter.dart';

class Haircare extends StatefulWidget {
  const Haircare({super.key});

  @override
  State<Haircare> createState() => _Haircare();
}

class _Haircare extends State<Haircare> {
  String? _selectedBrand;
  double _minRating = 0;
  RangeValues _priceRange =
      const RangeValues(0, 1500); // Initial safe value for beauty products

  final List<ProductsViewsModel> _allProducts = [
    ProductsViewsModel(
      id: '68132a95ff7813b3d47f9da11',
      title: 'L\'Oréal Paris Elvive Hyaluron Pure Shampoo 400ML',
      price: 142.20,
      originalPrice: 0.00,
      rating: 4.0,
      reviewCount: 19,
      brand: 'L\'Oréal Paris',
      imagePaths: ['assets/beauty_products/haircare_1/1.png'],
    ),
    ProductsViewsModel(
      id: '68132a95ff7813b3d47f9da12',
      title: 'Raw African Booster Shea Set',
      price: 650.00,
      originalPrice: 0.00,
      rating: 4.0,
      reviewCount: 19,
      brand: 'Raw African',
      imagePaths: ['assets/beauty_products/haircare_2/1.png'],
    ),
    ProductsViewsModel(
      id: '68132a95ff7813b3d47f9da13',
      title:
          'Garnier Color Naturals Permanent Crème Hair Color - 8.1 Light Ash Blonde',
      price: 132.00,
      originalPrice: 0.00,
      rating: 4.0,
      reviewCount: 19,
      brand: 'Garnier',
      imagePaths: ['assets/beauty_products/haircare_3/1.png'],
    ),
    ProductsViewsModel(
      id: '68132a95ff7813b3d47f9da14',
      title:
          'L\'Oreal Professionnel Absolut Repair 10-In-1 Hair Serum Oil - 90ml',
      price: 965.00,
      originalPrice: 1214.00,
      rating: 4.0,
      reviewCount: 19,
      brand: 'L\'Oreal Professionnel',
      imagePaths: ['assets/beauty_products/haircare_4/1.png'],
    ),
    ProductsViewsModel(
      id: '68132a95ff7813b3d47f9da15',
      title:
          'CORATED Heatless Curling Rod Headband Kit with Clips and Scrunchie',
      price: 94.96,
      originalPrice: 111.98,
      rating: 4.0,
      reviewCount: 19,
      brand: 'CORATED',
      imagePaths: ['assets/beauty_products/haircare_5/1.png'],
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
      appBar: buildAppBar(context: context, title: 'Haircare'),
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
                        productDetailView = const BeautyProduct11();
                        break;
                      case '68132a95ff7813b3d47f9da12':
                        productDetailView = const BeautyProduct12();
                        break;
                      case '68132a95ff7813b3d47f9da13':
                        productDetailView = const BeautyProduct13();
                        break;
                      case '68132a95ff7813b3d47f9da14':
                        productDetailView = const BeautyProduct14();
                        break;
                      case '68132a95ff7813b3d47f9da15':
                        productDetailView = const BeautyProduct15();
                        break;

                      default:
                        productDetailView =
                            const BeautyProduct1(); // Default fallback
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
