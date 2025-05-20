import 'package:flutter/material.dart';
import 'package:pickpay/core/widgets/build_appbar.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/products_views/video_games/video_games_product1.dart';
import 'package:pickpay/features/categories_pages/products_views/video_games/video_games_product2.dart';
import 'package:pickpay/features/categories_pages/products_views/video_games/video_games_product3.dart';
import 'package:pickpay/features/categories_pages/products_views/video_games/video_games_product4.dart';
import 'package:pickpay/features/categories_pages/widgets/brand_filter_widget.dart';
import 'package:pickpay/features/categories_pages/widgets/product_card.dart';
import 'package:pickpay/features/categories_pages/widgets/price_range_filter.dart';
import 'package:pickpay/features/categories_pages/widgets/rating_filter.dart';

class Console extends StatefulWidget {
  const Console({super.key});

  @override
  State<Console> createState() => _Console();
}

class _Console extends State<Console> {
  String? _selectedBrand;
  double _minRating = 0;
  RangeValues _priceRange =
      const RangeValues(0, 30000); // Initial safe value for video games

  final List<ProductsViewsModel> _allProducts = [
    ProductsViewsModel(
      id: 'vid1',
      title:
          'Sony PlayStation 5 SLIM Disc [ NEW 2023 Model ] - International Version',
      price: 27750.00,
      originalPrice: 28999.00,
      rating: 4.8,
      reviewCount: 88,
      brand: 'Sony',
      imagePaths: ['assets/videogames_products/Consoles/console1/2.png'],
    ),
    ProductsViewsModel(
      id: 'vid2',
      title: 'PlayStation 5 Digital Console (Slim)',
      price: 19600.00,
      originalPrice: 20800.00,
      rating: 4.7,
      reviewCount: 3538,
      brand: 'Sony',
      imagePaths: ['assets/videogames_products/Consoles/console2/1.png'],
    ),
    ProductsViewsModel(
      id: 'vid3',
      title: 'PlayStation 5 Digital Edition Slim (Nordic)',
      price: 28799.00,
      originalPrice: 20900.00,
      rating: 4.7,
      reviewCount: 3538,
      brand: 'Sony',
      imagePaths: ['assets/videogames_products/Consoles/console3/1.png'],
    ),
    ProductsViewsModel(
      id: 'vid4',
      title: 'Nintendo Switch OLED Mario Red Edition Gaming Console',
      price: 16990.00,
      originalPrice: 18989.00,
      rating: 4.9,
      reviewCount: 814,
      brand: 'Nintendo',
      imagePaths: ['assets/videogames_products/Consoles/console4/1.png'],
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
      appBar: buildAppBar(context: context, title: 'Console'),
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
                      case 'vid1':
                        productDetailView = const VideoGamesProduct1();
                        break;
                      case 'vid2':
                        productDetailView = const VideoGamesProduct2();
                        break;
                      case 'vid3':
                        productDetailView = const VideoGamesProduct3();
                        break;
                      case 'vid4':
                        productDetailView = const VideoGamesProduct4();
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
