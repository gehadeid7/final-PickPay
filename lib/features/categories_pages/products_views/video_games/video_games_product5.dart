import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/products_views/product_detail_view.dart';

class VideoGamesProduct5 extends StatelessWidget {
  const VideoGamesProduct5({super.key});

  @override
  Widget build(BuildContext context) {
    final product = ProductsViewsModel(
      id: '682b00a46977bd89257c0e84',
      title: 'Sony PlayStation 5 DualSense Wireless Controller',
      imagePaths: ['assets/videogames_products/Controllers/controller1/1.png'],
      price: 4499.00,
      originalPrice: 5000.00,
      rating: 5.0,
      reviewCount: 3,
      category: 'Video Games',
      subcategory: 'Controllers',
      aboutThisItem: '''Accessory Type: Controllers
Brand: Sony
Compatible with: other
This is wireless''',
      deliveryTimeLeft: '20hrs 36 mins',
      deliveryLocation: 'Egypt',
      inStock: true,
      shipsFrom: 'Pickpay',
      soldBy: 'Pickpay',
    );

    return ProductDetailView(product: product);
  }
}
