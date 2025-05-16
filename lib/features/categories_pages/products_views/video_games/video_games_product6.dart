import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/products_views/product_detail_view.dart';

class VideoGamesProduct6 extends StatelessWidget {
  const VideoGamesProduct6({super.key});

  @override
  Widget build(BuildContext context) {
    final product = ProductsViewsModel(
      id: 'vid6',
      title: 'PlayStation Sony DualSense wireless controller for PS5 White',
      imagePaths: [
        'assets/videogames_products/Controllers/controller2/1.png',
        'assets/videogames_products/Controllers/controller2/2.png',
        'assets/videogames_products/Controllers/controller2/3.png',
        'assets/videogames_products/Controllers/controller2/4.png',
      ],
      price: 4536.00,
      originalPrice: 5000.00,
      rating: 4.4,
      reviewCount: 2313,
      color: 'Black',
      compatibleDevices: 'Playstation 5',
      brand: 'PlayStation',
      controllerType: 'Gamepad',
      modelName: 'Sony DualSense wireless controller',
      connectivityTechnology: 'Wireless',
      buttonQuantity: '14',
      itemWeight: '0.05 Kilograms',
      itemPackageQuantity: '1',
      specialfeatures: 'Wireless, Rumble',
      aboutThisItem:
          '''Playstation 5 DualSense Wireless Controller for PS5 Console - Bulk Packaging - Gaming Accessories 

Adaptive triggers - Experience varying levels of force and tension as you interact with your in-game gear and environments. From pulling back an increasingly tight bowstring to hitting the brakes on a speeding car, feel physically connected to your on-screen actions.

Built-in microphone and headset jack - Chat with friends online using the built-in microphone or by connecting a headset to the 3.5mm jack. Easily switch voice capture on and off at a moment’s notice with the dedicated mute button. Internet and account for PlayStation Network required.''',
      deliveryTimeLeft: '20hrs 36 mins',
      deliveryLocation: 'Egypt',
      inStock: true,
      shipsFrom: 'Pickpay',
      soldBy: 'Pickpay',
    );

    return ProductDetailView(product: product);
  }
}
