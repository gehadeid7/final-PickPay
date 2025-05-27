import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/widgets/base_category_view.dart';
import 'package:pickpay/features/categories_pages/products_views/video_games/video_games_product1.dart';
import 'package:pickpay/features/categories_pages/products_views/video_games/video_games_product2.dart';
import 'package:pickpay/features/categories_pages/products_views/video_games/video_games_product3.dart';
import 'package:pickpay/features/categories_pages/products_views/video_games/video_games_product4.dart';

class Console extends StatelessWidget {
  Console({super.key});

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
      default:
        return const VideoGamesProduct1();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseCategoryView(
      categoryName: 'Console',
      products: _products,
      productDetailBuilder: _buildProductDetail,
    );
  }
}
