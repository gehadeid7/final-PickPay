import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/products_views/product_detail_view.dart';

class VideoGamesProduct3 extends StatelessWidget {
  const VideoGamesProduct3({super.key});

  @override
  Widget build(BuildContext context) {
    final product = ProductsViewsModel(
      id: 'vid3',
      title: 'PlayStation 5 Digital Edition Slim (Nordic)',
      imagePaths: [
        'assets/videogames_products/Consoles/console3/1.png',
        'assets/videogames_products/Consoles/console3/2.png',
        'assets/videogames_products/Consoles/console3/3.png',
        'assets/videogames_products/Consoles/console3/4.png',
      ],
      price: 28799.00,
      originalPrice: 20000.00,
      rating: 4.8,
      reviewCount: 36,
      category: 'Video Games',
      subcategory: 'Console',
      aboutThisItem: '1243374',
      deliveryTimeLeft: '20hrs 36 mins',
      deliveryLocation: 'Egypt',
      inStock: true,
      shipsFrom: 'Pickpay',
      soldBy: 'Pickpay',
    );

    return ProductDetailView(product: product);
  }
}
