import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/products_views/product_detail_view.dart';

class VideoGamesProduct9 extends StatelessWidget {
  const VideoGamesProduct9({super.key});

  @override
  Widget build(BuildContext context) {
    final product = ProductsViewsModel(
      id: 'vid9',
      title:
          'Nintendo 160 2 Nintendo Switch Joy-Con Controllers (Pastel Purple/Pastel Green)',
      imagePaths: [
        'assets/videogames_products/Controllers/controller5/1.png',
        'assets/videogames_products/Controllers/controller5/2.png',
        'assets/videogames_products/Controllers/controller5/3.png',
      ],
      price: 4300.00,
      originalPrice: 4988.00,
      rating: 4.3,
      reviewCount: 1872,
      color: 'multicoloured',
      compatibleDevices: 'Nintendo Switch',
      brand: 'Nintendo',
      controllerType: 'Gamepad',
      hardwarePlatform: 'Gaming Console',
      connectivityTechnology: 'USB',
      buttonQuantity: '5',
      itemWeight: '154 g',
      itemPackageQuantity: '1',
      specialfeatures: 'Wireless, Rumble, Ergonomic',
      aboutThisItem:
          '''The versatile joy-con offer multiple surprising ways for players to have fun

Two joy-con can be used independently in each hand or together as one game controller when attached to the joy-con grip (sold separately)

They can also attach to the main console for use in handheld mode or be shared with friends to enjoy two-player action in supported games''',
      deliveryTimeLeft: '20hrs 36 mins',
      deliveryLocation: 'Egypt',
      inStock: true,
      shipsFrom: 'Pickpay',
      soldBy: 'Pickpay',
    );

    return ProductDetailView(product: product);
  }
}
