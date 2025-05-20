import 'package:flutter/material.dart';
import 'package:pickpay/core/widgets/build_appbar.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/products_views/beauty_products_views/beauty_product1.dart';
import 'package:pickpay/features/categories_pages/products_views/beauty_products_views/beauty_product16.dart';
import 'package:pickpay/features/categories_pages/products_views/beauty_products_views/beauty_product17.dart';
import 'package:pickpay/features/categories_pages/products_views/beauty_products_views/beauty_product18.dart';
import 'package:pickpay/features/categories_pages/products_views/beauty_products_views/beauty_product19.dart';
import 'package:pickpay/features/categories_pages/products_views/beauty_products_views/beauty_product20.dart';
import 'package:pickpay/features/categories_pages/widgets/brand_filter_widget.dart';
import 'package:pickpay/features/categories_pages/widgets/product_card.dart';
import 'package:pickpay/features/categories_pages/widgets/price_range_filter.dart';
import 'package:pickpay/features/categories_pages/widgets/rating_filter.dart';

class Fragrance extends StatefulWidget {
  const Fragrance({super.key});

  @override
  State<Fragrance> createState() => _Fragrance();
}

class _Fragrance extends State<Fragrance> {
  String? _selectedBrand;
  double _minRating = 0;
  RangeValues _priceRange =
      const RangeValues(0, 1500); // Initial safe value for beauty products

  final List<ProductsViewsModel> _allProducts = [
    ProductsViewsModel(
      id: '68132a95ff7813b3d47f9da16',
      title: 'Avon Far Away for Women, Floral Eau de Parfum 50ml',
      price: 534.51,
      originalPrice: 0.00,
      rating: 4.0,
      reviewCount: 19,
      brand: 'Avon',
      imagePaths: ['assets/beauty_products/fragrance_1/1.png'],
    ),
    ProductsViewsModel(
      id: '68132a95ff7813b3d47f9da17',
      title:
          'Memwa Coco Memwa Long Lasting Perfume Fragrance Luxury Eau De Parfum EDP Perfume for Women',
      price: 624.04,
      originalPrice: 624.04,
      rating: 4.0,
      reviewCount: 19,
      brand: 'Memwa',
      imagePaths: ['assets/beauty_products/fragrance_2/1.png'],
    ),
    ProductsViewsModel(
      id: '68132a95ff7813b3d47f9da18',
      title:
          'Bath Body Gingham Gorgeous Fine Fragrance Mist, Size/Volume: 8 fl oz / 236 mL',
      price: 1350.00,
      originalPrice: 1350.00,
      rating: 4.0,
      reviewCount: 19,
      brand: 'Bath Body',
      imagePaths: ['assets/beauty_products/fragrance_3/1.png'],
    ),
    ProductsViewsModel(
      id: '68132a95ff7813b3d47f9da19',
      title:
          'NIVEA Antiperspirant Spray for Women, Pearl & Beauty Pearl Extracts, 150ml',
      price: 123.00,
      originalPrice: 123.00,
      rating: 4.0,
      reviewCount: 19,
      brand: 'NIVEA',
      imagePaths: ['assets/beauty_products/fragrance_4/1.png'],
    ),
    ProductsViewsModel(
      id: '68132a95ff7813b3d47f9da20',
      title: 'Jacques Bogart One Man Show for Men, Eau de Toilette - 100ml',
      price: 840.00,
      originalPrice: 900.00,
      rating: 4.0,
      reviewCount: 19,
      brand: 'Jacques Bogart',
      imagePaths: ['assets/beauty_products/fragrance_5/1.png'],
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
      appBar: buildAppBar(context: context, title: 'Fragrance'),
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
                      case '68132a95ff7813b3d47f9da16':
                        productDetailView = const BeautyProduct16();
                        break;
                      case '68132a95ff7813b3d47f9da17':
                        productDetailView = const BeautyProduct17();
                        break;
                      case '68132a95ff7813b3d47f9da18':
                        productDetailView = const BeautyProduct18();
                        break;
                      case '68132a95ff7813b3d47f9da19':
                        productDetailView = const BeautyProduct19();
                        break;
                      case '68132a95ff7813b3d47f9da20':
                        productDetailView = const BeautyProduct20();
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
