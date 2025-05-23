import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/widgets/base_category_view.dart';
import 'package:pickpay/features/categories_pages/products_views/video_games/video_games_product1.dart';
import 'package:pickpay/features/categories_pages/products_views/video_games/video_games_product2.dart';
import 'package:pickpay/features/categories_pages/products_views/video_games/video_games_product3.dart';
import 'package:pickpay/features/categories_pages/products_views/video_games/video_games_product4.dart';
import 'package:pickpay/features/categories_pages/products_views/video_games/video_games_product5.dart';
import 'package:pickpay/features/categories_pages/products_views/video_games/video_games_product6.dart';
import 'package:pickpay/features/categories_pages/products_views/video_games/video_games_product7.dart';
import 'package:pickpay/features/categories_pages/products_views/video_games/video_games_product8.dart';
import 'package:pickpay/features/categories_pages/products_views/video_games/video_games_product9.dart';
import 'package:pickpay/features/categories_pages/products_views/video_games/video_games_product10.dart';
import 'package:pickpay/features/categories_pages/products_views/video_games/video_games_product11.dart';
import 'package:pickpay/features/categories_pages/products_views/video_games/video_games_product12.dart';
import 'package:pickpay/features/categories_pages/products_views/video_games/video_games_product13.dart';
import 'package:pickpay/features/categories_pages/products_views/video_games/video_games_product14.dart';

class VideogamesViewBody extends StatelessWidget {
  VideogamesViewBody({super.key});

  final List<ProductsViewsModel> _products = [
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

  Widget _buildProductDetail(String productId) {
    switch (productId) {
      case 'vid1':
        return const VideoGamesProduct1();
      case 'vid2':
        return const VideoGamesProduct2();
      case 'vid3':
        return const VideoGamesProduct3();
      case 'vid4':
        return const VideoGamesProduct4();
      case 'vid5':
        return const VideoGamesProduct5();
      case 'vid6':
        return const VideoGamesProduct6();
      case 'vid7':
        return const VideoGamesProduct7();
      case 'vid8':
        return const VideoGamesProduct8();
      case 'vid9':
        return const VideoGamesProduct9();
      case 'vid10':
        return const VideoGamesProduct10();
      case 'vid11':
        return const VideoGamesProduct11();
      case 'vid12':
        return const VideoGamesProduct12();
      case 'vid13':
        return const VideoGamesProduct13();
      case 'vid14':
        return const VideoGamesProduct14();
      default:
        return const VideoGamesProduct1();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseCategoryView(
      categoryName: 'Video Games',
      products: _products,
      productDetailBuilder: _buildProductDetail,
    );
  }
}
