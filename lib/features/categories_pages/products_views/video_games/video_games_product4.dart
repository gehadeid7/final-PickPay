import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/products_views/product_detail_view.dart';

class VideoGamesProduct4 extends StatelessWidget {
  const VideoGamesProduct4({super.key});

  @override
  Widget build(BuildContext context) {
    final product = ProductsViewsModel(
      id: 'vid4',
      title: 'Nintendo Switch OLED Mario Red Edition Gaming Console',
      imagePaths: [
        'assets/videogames_products/Consoles/console4/1.png',
        'assets/videogames_products/Consoles/console4/2.png',
        'assets/videogames_products/Consoles/console4/3.png',
        'assets/videogames_products/Consoles/console4/4.png',
      ],
      price: 16990.00,
      originalPrice: 18000.00,
      rating: 4.7,
      reviewCount: 913,
      category: 'Video Games',
      subcategory: 'Console',
      aboutThisItem:
          '''Boasts a stunning design with a vibrant red color scheme 

OLED display enhances every moment

Comes bundled with a pair of red joy-con controllers

Supports both handheld and docked modes

Fantastic addition to your gaming collection''',
      deliveryTimeLeft: '20hrs 36 mins',
      deliveryLocation: 'Egypt',
      inStock: true,
      shipsFrom: 'Pickpay',
      soldBy: 'Pickpay',
    );

    return ProductDetailView(product: product);
  }
}
