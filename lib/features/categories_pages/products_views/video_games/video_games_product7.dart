import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/products_views/product_detail_view.dart';

class VideoGamesProduct7 extends StatelessWidget {
  const VideoGamesProduct7({super.key});

  @override
  Widget build(BuildContext context) {
    final product = ProductsViewsModel(
      id: 'vid7',
      title: 'PlayStation 5 Dual Sense Wireless Controller Cosmic Red',
      imagePaths: ['assets/videogames_products/Controllers/controller3/1.png'],
      price: 4498.99,
      originalPrice: 4999.00,
      rating: 4.4,
      reviewCount: 3,
      aboutThisItem: '''Sleek design
Packed with features
Cutting-edge technology
Unparalleled performance.''',
      deliveryTimeLeft: '20hrs 36 mins',
      deliveryLocation: 'Egypt',
      inStock: true,
      shipsFrom: 'Pickpay',
      soldBy: 'Pickpay',
    );

    return ProductDetailView(product: product);
  }
}
