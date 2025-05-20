import 'package:flutter/material.dart';
import 'package:pickpay/core/widgets/build_appbar.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/products_views/beauty_products_views/beauty_product1.dart';
import 'package:pickpay/features/categories_pages/products_views/beauty_products_views/beauty_product10.dart';
import 'package:pickpay/features/categories_pages/products_views/beauty_products_views/beauty_product6.dart';
import 'package:pickpay/features/categories_pages/products_views/beauty_products_views/beauty_product7.dart';
import 'package:pickpay/features/categories_pages/products_views/beauty_products_views/beauty_product8.dart';
import 'package:pickpay/features/categories_pages/products_views/beauty_products_views/beauty_product9.dart';
import 'package:pickpay/features/categories_pages/widgets/brand_filter_widget.dart';
import 'package:pickpay/features/categories_pages/widgets/product_card.dart';
import 'package:pickpay/features/categories_pages/widgets/price_range_filter.dart';
import 'package:pickpay/features/categories_pages/widgets/rating_filter.dart';

class Skincare extends StatefulWidget {
  const Skincare({super.key});

  @override
  State<Skincare> createState() => _Skincare();
}

class _Skincare extends State<Skincare> {
  String? _selectedBrand;
  double _minRating = 0;
  RangeValues _priceRange =
      const RangeValues(0, 1500); // Initial safe value for beauty products

  final List<ProductsViewsModel> _allProducts = [
    ProductsViewsModel(
      id: '68132a95ff7813b3d47f9da6',
      title: 'Care & More Soft Cream With Glycerin Mixed berries 75 ML',
      price: 31.00,
      originalPrice: 44.00,
      rating: 4.0,
      reviewCount: 19,
      brand: 'Care & More',
      imagePaths: ['assets/beauty_products/skincare_1/1.png'],
    ),
    ProductsViewsModel(
      id: '68132a95ff7813b3d47f9da7',
      title:
          'La Roche-Posay Anthelios XL Non-perfumed Dry Touch oil control gel cream SPF50+ 50ml',
      price: 1168.70,
      originalPrice: 1168.70,
      rating: 4.0,
      reviewCount: 19,
      brand: 'La Roche-Posay',
      imagePaths: ['assets/beauty_products/skincare_2/1.png'],
    ),
    ProductsViewsModel(
      id: '68132a95ff7813b3d47f9da8',
      title:
          'Eva Aloe skin clinic anti-ageing collagen toner for firmed and refined skin - 200ml',
      price: 138.60,
      originalPrice: 210.00,
      rating: 4.0,
      reviewCount: 19,
      brand: 'Eva',
      imagePaths: ['assets/beauty_products/skincare_3/1.png'],
    ),
    ProductsViewsModel(
      id: '68132a95ff7813b3d47f9da9',
      title:
          'Eucerin DermoPurifyer Oil Control Skin Renewal Treatment Face Serum, 40ml',
      price: 658.93,
      originalPrice: 775.00,
      rating: 4.0,
      reviewCount: 19,
      brand: 'Eucerin',
      imagePaths: ['assets/beauty_products/skincare_4/1.png'],
    ),
    ProductsViewsModel(
      id: '68132a95ff7813b3d47f9da10',
      title: 'L\'Oréal Paris Hyaluron Expert Eye Serum - 20ml',
      price: 429.00,
      originalPrice: 0.00,
      rating: 4.8,
      reviewCount: 19,
      brand: 'L\'Oréal Paris',
      imagePaths: ['assets/beauty_products/skincare_5/1.png'],
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
      appBar: buildAppBar(context: context, title: 'Skincare'),
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
                        productDetailView = const BeautyProduct6();
                        break;
                      case '68132a95ff7813b3d47f9da7':
                        productDetailView = const BeautyProduct7();
                        break;
                      case '68132a95ff7813b3d47f9da8':
                        productDetailView = const BeautyProduct8();
                        break;
                      case '68132a95ff7813b3d47f9da9':
                        productDetailView = const BeautyProduct9();
                        break;
                      case '68132a95ff7813b3d47f9da10':
                        productDetailView = const BeautyProduct10();
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
