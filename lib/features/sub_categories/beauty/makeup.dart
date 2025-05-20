import 'package:flutter/material.dart';
import 'package:pickpay/core/widgets/build_appbar.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/products_views/beauty_products_views/beauty_product1.dart';
import 'package:pickpay/features/categories_pages/products_views/beauty_products_views/beauty_product2.dart';
import 'package:pickpay/features/categories_pages/products_views/beauty_products_views/beauty_product3.dart';
import 'package:pickpay/features/categories_pages/products_views/beauty_products_views/beauty_product4.dart';
import 'package:pickpay/features/categories_pages/products_views/beauty_products_views/beauty_product5.dart';
import 'package:pickpay/features/categories_pages/widgets/brand_filter_widget.dart';
import 'package:pickpay/features/categories_pages/widgets/product_card.dart';
import 'package:pickpay/features/categories_pages/widgets/price_range_filter.dart';
import 'package:pickpay/features/categories_pages/widgets/rating_filter.dart';

class Makeup extends StatefulWidget {
  const Makeup({super.key});

  @override
  State<Makeup> createState() => _Makeup();
}

class _Makeup extends State<Makeup> {
  String? _selectedBrand;
  double _minRating = 0;
  RangeValues _priceRange =
      const RangeValues(0, 1500); // Initial safe value for beauty products

  final List<ProductsViewsModel> _allProducts = [
    ProductsViewsModel(
      id: '68132a95ff7813b3d47f9da1',
      title:
          'L\'Oréal Paris Volume Million Lashes Panorama Mascara in Black, 9.9 ml',
      price: 401.00,
      originalPrice: 730.00,
      rating: 5.0,
      reviewCount: 88,
      brand: 'L\'Oréal Paris',
      imagePaths: ['assets/beauty_products/makeup_1/1.png'],
    ),
    ProductsViewsModel(
      id: '68132a95ff7813b3d47f9da2',
      title:
          'L\'Oréal Paris Infaillible 24H Matte Cover Foundation 200 Sable Dore - Oil Control, High Coverage',
      price: 509.00,
      originalPrice: 575.00,
      rating: 5.0,
      reviewCount: 88,
      brand: 'L\'Oréal Paris',
      imagePaths: ['assets/beauty_products/makeup_2/1.png'],
    ),
    ProductsViewsModel(
      id: '68132a95ff7813b3d47f9da3',
      title: 'Cybele Smooth N`Wear Powder Blush Corail 17 - 3.7gm',
      price: 227.20,
      originalPrice: 240.00,
      rating: 5.0,
      reviewCount: 88,
      brand: 'Cybele',
      imagePaths: ['assets/beauty_products/makeup_3/1.png'],
    ),
    ProductsViewsModel(
      id: '68132a95ff7813b3d47f9da4',
      title:
          'Eva skin care cleansing & makeup remover facial wipes for normal/dry skin 20%',
      price: 63.00,
      originalPrice: 63.00,
      rating: 5.0,
      reviewCount: 92,
      brand: 'Eva',
      imagePaths: ['assets/beauty_products/makeup_4/1.png'],
    ),
    ProductsViewsModel(
      id: '68132a95ff7813b3d47f9da5',
      title: 'Maybelline New York Lifter Lip Gloss, 005 Petal',
      price: 300.00,
      originalPrice: 310.00,
      rating: 5.0,
      reviewCount: 88,
      brand: 'Maybelline',
      imagePaths: ['assets/beauty_products/makeup_5/1.png'],
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
      appBar: buildAppBar(context: context, title: 'Makeup'),
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
                      case '68132a95ff7813b3d47f9da1':
                        productDetailView = const BeautyProduct1();
                        break;
                      case '68132a95ff7813b3d47f9da2':
                        productDetailView = const BeautyProduct2();
                        break;
                      case '68132a95ff7813b3d47f9da3':
                        productDetailView = const BeautyProduct3();
                        break;
                      case '68132a95ff7813b3d47f9da4':
                        productDetailView = const BeautyProduct4();
                        break;
                      case '68132a95ff7813b3d47f9da5':
                        productDetailView = const BeautyProduct5();
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
