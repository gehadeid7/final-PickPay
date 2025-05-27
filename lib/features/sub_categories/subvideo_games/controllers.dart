import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/widgets/base_category_view.dart';
import 'package:pickpay/features/categories_pages/products_views/video_games/video_games_product1.dart';
import 'package:pickpay/features/categories_pages/products_views/video_games/video_games_product5.dart';
import 'package:pickpay/features/categories_pages/products_views/video_games/video_games_product6.dart';
import 'package:pickpay/features/categories_pages/products_views/video_games/video_games_product7.dart';
import 'package:pickpay/features/categories_pages/products_views/video_games/video_games_product8.dart';
import 'package:pickpay/features/categories_pages/products_views/video_games/video_games_product9.dart';

class Controllers extends StatelessWidget {
  Controllers({super.key});

  final List<ProductsViewsModel> _products = [
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

  Widget _buildProductDetail(String productId) {
    switch (productId) {
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
      default:
        return const VideoGamesProduct1();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseCategoryView(
      categoryName: 'Controllers',
      products: _products,
      productDetailBuilder: _buildProductDetail,
    );
  }
}
