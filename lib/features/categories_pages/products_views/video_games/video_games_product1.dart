import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/products_views/product_detail_view.dart';

class VideoGamesProduct1 extends StatelessWidget {
  const VideoGamesProduct1({super.key});

  @override
  Widget build(BuildContext context) {
    final product = ProductsViewsModel(
      id: 'vid1',
      title:
          'Sony PlayStation 5 SLIM Disc [ NEW 2023 Model ] - International Version',
      imagePaths: [
        'assets/videogames_products/Consoles/console1/1.png',
        'assets/videogames_products/Consoles/console1/2.png',
        'assets/videogames_products/Consoles/console1/3.png',
      ],
      price: 27750.00,
      originalPrice: 28899.00,
      rating: 4.6,
      reviewCount: 893,
      category: 'Video Games',
      subcategory: 'Console',
      aboutThisItem:
          '''With PS5 Digital Edition, players get powerful gaming technology packed inside a sleek and compact console design

Keep your favourite games ready and waiting for you to jump in and play with 1TB of SSD storage built in

Maximize your play sessions with near instant load times for installed PS5 games

The custom integration of the PS5 console's systems lets creators pull data from the SSD so quickly that they can design games in ways never before possible

Immerse yourself in worlds with a new level of realism as rays of light are individually simulated, creating true-to-life shadows and reflections in supported PS5 games''',
      deliveryTimeLeft: '20hrs 36 mins',
      deliveryLocation: 'Egypt',
      inStock: true,
      shipsFrom: 'Pickpay',
      soldBy: 'Pickpay',
    );

    return ProductDetailView(product: product);
  }
}
