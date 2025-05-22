import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/products_views/product_detail_view.dart';

class VideoGamesProduct10 extends StatelessWidget {
  const VideoGamesProduct10({super.key});

  @override
  Widget build(BuildContext context) {
    final product = ProductsViewsModel(
      id: 'vid10',
      title:
          'Likorlove PS5 Controller Quick Charger, Dual USB Fast Charging Dock Station Stand for Playstation 5 DualSense Controllers Console with LED Indicator USB Type C Ports, White [2.5-3 Hours]',
      imagePaths: [
        'assets/videogames_products/Accessories/accessories1/1.png',
        'assets/videogames_products/Accessories/accessories1/2.png',
        'assets/videogames_products/Accessories/accessories1/3.png',
        'assets/videogames_products/Accessories/accessories1/4.png',
      ],
      price: 576.00,
      originalPrice: 600.00,
      rating: 4.3,
      reviewCount: 185,
      category: 'Video Games',
      subcategory: 'Accessories',
      color: 'Green',
      compatibleDevices: 'Game Consoles',
      brand: 'Likorlove',
      connectorType: 'USB',
      compatiblePhoneModels: 'Sony',
      connectivityTechnology: 'USB',
      includedComponents: '1 USB Type C cable',
      inputVoltage: '5 Volts',
      mountingType: 'Tabletop Mount',
      specialfeatures: 'Fast Charging',
      aboutThisItem:
          '''🎮【Dual Controller Charging Simultaneously】 The Likorlove PS5 charging station is designed to charge 2 PS5 controllers at the same time. It's a necessary accessories for ps5 gamers.

🎮【2.5H Quick Charge & Overcharging Protection】 5.3V/3A PS5 charging cable supports fast charging for 2 controllers. It will be better to charge your controllers with adapter directly, it will be slower when connecting with PS5 host or another USB hub.

🎮【LED Indicator & Easy to Install】 You can know directly at a glance on those two LED indicators, red for charging, green for fully charged or power connecting. You can only install your ps5 dualsense controllers into the PS5 controller charging dock and it will start charging.

🎮【Intelligent & Safety Charging】 The built-in intelligent chip provides intelligent overload protection. It will protect your ps5 controllers from over-charging, over-voltage, overheat and short-circuit.

🎮【Compact Stable Charging Stand】 Compact and sleek charging station for PS5 dualsense controllers, it won't take up too much space on your gaming desk. It can not only quickly charging two of your ps5 controllers, but also a controller storage stand for them. Any problems please feel free to contact our technical support with 1 year quality guarantee.''',
      deliveryTimeLeft: '20hrs 36 mins',
      deliveryLocation: 'Egypt',
      inStock: true,
      shipsFrom: 'Pickpay',
      soldBy: 'Pickpay',
    );

    return ProductDetailView(product: product);
  }
}
