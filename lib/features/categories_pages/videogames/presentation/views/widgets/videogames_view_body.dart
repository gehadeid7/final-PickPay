import 'package:flutter/material.dart';
import 'package:pickpay/core/widgets/build_appbar.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/products_views/video_games/video_games_product1.dart';
import 'package:pickpay/features/categories_pages/products_views/video_games/video_games_product10.dart';
import 'package:pickpay/features/categories_pages/products_views/video_games/video_games_product11.dart';
import 'package:pickpay/features/categories_pages/products_views/video_games/video_games_product12.dart';
import 'package:pickpay/features/categories_pages/products_views/video_games/video_games_product13.dart';
import 'package:pickpay/features/categories_pages/products_views/video_games/video_games_product14.dart';
import 'package:pickpay/features/categories_pages/products_views/video_games/video_games_product2.dart';
import 'package:pickpay/features/categories_pages/products_views/video_games/video_games_product3.dart';
import 'package:pickpay/features/categories_pages/products_views/video_games/video_games_product4.dart';
import 'package:pickpay/features/categories_pages/products_views/video_games/video_games_product5.dart';
import 'package:pickpay/features/categories_pages/products_views/video_games/video_games_product6.dart';
import 'package:pickpay/features/categories_pages/products_views/video_games/video_games_product7.dart';
import 'package:pickpay/features/categories_pages/products_views/video_games/video_games_product8.dart';
import 'package:pickpay/features/categories_pages/products_views/video_games/video_games_product9.dart';
import 'package:pickpay/features/categories_pages/widgets/brand_filter_widget.dart';
import 'package:pickpay/features/categories_pages/widgets/product_card.dart';
import 'package:pickpay/features/categories_pages/widgets/price_range_filter.dart';
import 'package:pickpay/features/categories_pages/widgets/rating_filter.dart';

class VideogamesViewBody extends StatefulWidget {
  const VideogamesViewBody({super.key});

  @override
  State<VideogamesViewBody> createState() => _VideogamesViewBodyState();
}

class _VideogamesViewBodyState extends State<VideogamesViewBody> {
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
    ProductsViewsModel(
      id: 'vid10',
      title:
          'Likorlove PS5 Controller Quick Charger, Dual USB Fast Charging Dock Station Stand for Playstation 5 DualSense Controllers Console with LED Indicator USB Type C Ports, White [2.5-3 Hours]',
      price: 750.00,
      originalPrice: 800.99,
      rating: 4.8,
      reviewCount: 2571,
      brand: 'Likorlove',
      imagePaths: ['assets/videogames_products/Accessories/accessories1/1.png'],
    ),
    ProductsViewsModel(
      id: 'vid11',
      title:
          'OIVO PS5 Charging Station, 2H Fast PS5 Controller Charger for Playstation 5 Dualsense Controller, Upgrade PS5 Charging Dock with 2 Types of Cable, PS5 Charger for Dual PS5 Controller',
      price: 1200.00,
      originalPrice: 1300.00,
      rating: 4.6,
      reviewCount: 15736,
      brand: 'OIVO',
      imagePaths: ['assets/videogames_products/Accessories/accessories2/1.png'],
    ),
    ProductsViewsModel(
      id: 'vid12',
      title:
          'fanxiang S770 4TB NVMe M.2 SSD for PS5 - with Heatsink and DRAM, Up to 7300MB/s, PCIe 4.0, Suitable for Playstation 5 Memory Expansion, Game Enthusiasts, IT Professionals',
      price: 26200.00,
      originalPrice: 26999.00,
      rating: 4.3,
      reviewCount: 230,
      brand: 'fanxiang',
      imagePaths: ['assets/videogames_products/Accessories/accessories3/1.png'],
    ),
    ProductsViewsModel(
      id: 'vid13',
      title:
          'Mcbazel PS5 Cooling Station and Charging Station, 3 Speed Fan, Controller Dock with LED Indicator and 11 Storage Discs - White(Not for PS5 Pro)',
      price: 1999.00,
      originalPrice: 2100.00,
      rating: 3.9,
      reviewCount: 38,
      brand: 'Mcbazel',
      imagePaths: ['assets/videogames_products/Accessories/accessories4/1.png'],
    ),
    ProductsViewsModel(
      id: 'vid14',
      title: 'EA SPORTS FC 25 Standard Edition PS5 | VideoGame | English',
      price: 2800.00,
      originalPrice: 2900.00,
      rating: 4.5,
      reviewCount: 1530,
      brand: 'EA Sports',
      imagePaths: ['assets/videogames_products/Accessories/accessories5/1.png'],
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
      appBar: buildAppBar(context: context, title: 'Video Games'),
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
                      case 'vid10':
                        productDetailView = const VideoGamesProduct10();
                        break;
                      case 'vid11':
                        productDetailView = const VideoGamesProduct11();
                        break;
                      case 'vid12':
                        productDetailView = const VideoGamesProduct12();
                        break;
                      case 'vid13':
                        productDetailView = const VideoGamesProduct13();
                        break;
                      case 'vid14':
                        productDetailView = const VideoGamesProduct14();
                        break;
                      // Add cases for other products as needed
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
