import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/products_views/product_detail_view.dart';

class VideoGamesProduct11 extends StatelessWidget {
  const VideoGamesProduct11({super.key});

  @override
  Widget build(BuildContext context) {
    final product = ProductsViewsModel(
      id: '682b00a46977bd89257c0e8a',
      title:
          'OIVO PS5 Charging Station, 2H Fast PS5 Controller Charger for Playstation 5 Dualsense Controller, Upgrade PS5 Charging Dock with 2 Types of Cable, PS5 Charger for Dual PS5 Controller',
      imagePaths: [
        'assets/videogames_products/Accessories/accessories2/1.png',
        'assets/videogames_products/Accessories/accessories2/2.png',
        'assets/videogames_products/Accessories/accessories2/3.png',
        'assets/videogames_products/Accessories/accessories2/4.png',
      ],
      price: 1200.00,
      originalPrice: 1300.00,
      rating: 4.6,
      reviewCount: 15736,
      category: 'Video Games',
      subcategory: 'Accessories',
      aboutThisItem:
          '''🎮This PlayStation 5 charging station has a smart chip which increases Voltage whilst maintaining all-round protection for your PS5 remotes

🎮This PS5 charger dock features the same Black and white colour scheme as the PS5 console making it blend in seamlessly with your existing Setup

🎮After listening to feedbacks from the video games community, we have now added an on/off Switch to the back of PS5 charging dock

🎮We have designed our PS5 controller charger stand with ease of use in mind. Simply connect the dock to your PlayStation 5 console and place the controllers directly onto the PS5 charging dock

🎮Also included anti-slip pads on the base of the dual charging station which prevents it from sliding when placed on your entertainment system or desk''',
      deliveryTimeLeft: '20hrs 36 mins',
      deliveryLocation: 'Egypt',
      inStock: true,
      shipsFrom: 'Pickpay',
      soldBy: 'Pickpay',
    );

    return ProductDetailView(product: product);
  }
}
