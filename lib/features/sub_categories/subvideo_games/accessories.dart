import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/widgets/base_category_view.dart';
import 'package:pickpay/features/categories_pages/products_views/video_games/video_games_product1.dart';
import 'package:pickpay/features/categories_pages/products_views/video_games/video_games_product10.dart';
import 'package:pickpay/features/categories_pages/products_views/video_games/video_games_product11.dart';
import 'package:pickpay/features/categories_pages/products_views/video_games/video_games_product12.dart';
import 'package:pickpay/features/categories_pages/products_views/video_games/video_games_product13.dart';
import 'package:pickpay/features/categories_pages/products_views/video_games/video_games_product14.dart';

class Accessories extends StatelessWidget {
  Accessories({super.key});

  final List<ProductsViewsModel> _products = [
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
      categoryName: 'Accessories',
      products: _products,
      productDetailBuilder: _buildProductDetail,
    );
  }
}
