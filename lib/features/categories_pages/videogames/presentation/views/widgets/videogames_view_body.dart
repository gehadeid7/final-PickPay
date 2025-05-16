import 'package:flutter/material.dart';
import 'package:pickpay/constants.dart';
import 'package:pickpay/core/widgets/build_appbar.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/products_views/video_games/video_games_product1.dart';
import 'package:pickpay/features/categories_pages/products_views/video_games/video_games_product2.dart';
import 'package:pickpay/features/categories_pages/widgets/brand_filter_widget.dart';
import 'package:pickpay/features/categories_pages/widgets/product_card.dart';

class VideogamesViewBody extends StatefulWidget {
  const VideogamesViewBody({super.key});

  @override
  State<VideogamesViewBody> createState() => _VideogamesViewBodyState();
}

class _VideogamesViewBodyState extends State<VideogamesViewBody> {
  String? _selectedBrand;
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
      price: 4499.00,
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
      price: 1375.00,
      originalPrice: 1599.00,
      rating: 4.8,
      reviewCount: 2571,
      brand: 'OIVO',
      imagePaths: ['assets/videogames_products/Accessories/accessories2/1.png'],
    ),
    ProductsViewsModel(
      id: 'vid12',
      title:
          'fanxiang S770 4TB NVMe M.2 SSD for PS5 - with Heatsink and DRAM, Up to 7300MB/s, PCIe 4.0, Suitable for Playstation 5 Memory Expansion, Game Enthusiasts, IT Professionals',
      price: 26200.00,
      originalPrice: 26999.00,
      rating: 4.8,
      reviewCount: 2571,
      brand: 'fanxiang',
      imagePaths: ['assets/videogames_products/Accessories/accessories3/1.png'],
    ),
    ProductsViewsModel(
      id: 'vid13',
      title:
          'Mcbazel PS5 Cooling Station and Charging Station, 3 Speed Fan, Controller Dock with LED Indicator and 11 Storage Discs - White(Not for PS5 Pro)',
      price: 2122.00,
      originalPrice: 2555.00,
      rating: 4.8,
      reviewCount: 2571,
      brand: 'Mcbazel',
      imagePaths: ['assets/videogames_products/Accessories/accessories4/1.png'],
    ),
    ProductsViewsModel(
      id: 'vid14',
      title: 'EA SPORTS FC 25 Standard Edition PS5 | VideoGame | English',
      price: 3216.00,
      originalPrice: 3490.00,
      rating: 4.8,
      reviewCount: 2571,
      brand: 'EA Sports',
      imagePaths: ['assets/videogames_products/Accessories/accessories5/1.png'],
    ),
  ];

  List<ProductsViewsModel> get _filteredProducts {
    if (_selectedBrand == null ||
        _selectedBrand!.isEmpty ||
        _selectedBrand == 'All Brands') {
      return _allProducts;
    }
    return _allProducts
        .where((product) => product.brand == _selectedBrand)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context: context, title: 'Video Games'),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          SizedBox(height: kTopPadding),
          Align(
            alignment: Alignment.centerLeft,
            child: SizedBox(
              width: 150,
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
          ),
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
                      // Add cases for other products as needed
                      default:
                        productDetailView =
                            const VideoGamesProduct1(); // Default fallback
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
          }).toList(),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
