import 'package:flutter/material.dart';
import 'package:pickpay/core/widgets/build_appbar.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/products_views/video_games/video_games_product1.dart';
import 'package:pickpay/features/categories_pages/products_views/video_games/video_games_product5.dart';
import 'package:pickpay/features/categories_pages/products_views/video_games/video_games_product6.dart';
import 'package:pickpay/features/categories_pages/products_views/video_games/video_games_product7.dart';
import 'package:pickpay/features/categories_pages/products_views/video_games/video_games_product8.dart';
import 'package:pickpay/features/categories_pages/products_views/video_games/video_games_product9.dart';
import 'package:pickpay/features/categories_pages/widgets/brand_filter_widget.dart';
import 'package:pickpay/features/categories_pages/widgets/product_card.dart';
import 'package:pickpay/features/categories_pages/widgets/price_range_filter.dart';
import 'package:pickpay/features/categories_pages/widgets/rating_filter.dart';

class Controllers extends StatefulWidget {
  const Controllers({super.key});

  @override
  State<Controllers> createState() => _Controllers();
}

class _Controllers extends State<Controllers> {
  String? _selectedBrand;
  double _minRating = 0;
  RangeValues _priceRange =
      const RangeValues(0, 30000); // Initial safe value for video games

  final List<ProductsViewsModel> _allProducts = [
    ProductsViewsModel(
      id: 'vid5',
      title: 'Sony PlayStation 5 DualSense Wireless Controller',
      price: 4499.00,
      originalPrice: 5000.00,
      rating: 4.4,
      reviewCount: 557,
      brand: 'Sony',
      imagePaths: ['assets/videogames_products/Controllers/controller1/1.png'],
    ),
    ProductsViewsModel(
      id: 'vid6',
      title: 'PlayStation Sony DualSense wireless controller for PS5 White',
      price: 4536.00,
      originalPrice: 5000.00,
      rating: 4.2,
      reviewCount: 698,
      brand: 'Sony',
      imagePaths: ['assets/videogames_products/Controllers/controller2/1.png'],
    ),
    ProductsViewsModel(
      id: 'vid7',
      title: 'PlayStation 5 Dual Sense Wireless Controller Cosmic Red',
      price: 4498.00,
      originalPrice: 4900.00,
      rating: 4.8,
      reviewCount: 2571,
      brand: 'Sony',
      imagePaths: ['assets/videogames_products/Controllers/controller3/1.png'],
    ),
    ProductsViewsModel(
      id: 'vid8',
      title: 'PlayStation 5 DualSense Edge Wireless Controller (UAE Version)',
      price: 16500.00,
      originalPrice: 17000.00,
      rating: 4.8,
      reviewCount: 2571,
      brand: 'Sony',
      imagePaths: ['assets/videogames_products/Controllers/controller4/1.png'],
    ),
    ProductsViewsModel(
      id: 'vid9',
      title:
          'Nintendo 160 2 Nintendo Switch Joy-Con Controllers (Pastel Purple/Pastel Green)',
      price: 4300.00,
      originalPrice: 4988.00,
      rating: 4.8,
      reviewCount: 2571,
      brand: 'Nintendo',
      imagePaths: ['assets/videogames_products/Controllers/controller5/1.png'],
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
      appBar: buildAppBar(context: context, title: 'Controllers'),
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
                      case 'vid5':
                        productDetailView = const VideoGamesProduct5();
                        break;
                      case 'vid6':
                        productDetailView = const VideoGamesProduct6();
                        break;
                      case 'vid7':
                        productDetailView = const VideoGamesProduct7();
                        break;
                      case 'vid8':
                        productDetailView = const VideoGamesProduct8();
                        break;
                      case 'vid9':
                        productDetailView = const VideoGamesProduct9();
                        break;

                      default:
                        productDetailView = const VideoGamesProduct1();
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
