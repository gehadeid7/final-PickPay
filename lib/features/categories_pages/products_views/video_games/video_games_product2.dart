import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/products_views/product_detail_view.dart';

class VideoGamesProduct2 extends StatelessWidget {
  const VideoGamesProduct2({super.key});

  @override
  Widget build(BuildContext context) {
    final product = ProductsViewsModel(
      id: 'vid2',
      title:
          'Sony Ps4 500Gb Standalone Jet Black With One Dual Shock Controller (Ps4)',
      imagePaths: [
        'assets/videogames_products/Consoles/console2/1.png',
        'assets/videogames_products/Consoles/console2/2.png',
        'assets/videogames_products/Consoles/console2/3.png',
        'assets/videogames_products/Consoles/console2/4.png',
      ],
      price: 19600.00,
      originalPrice: 20000.00,
      rating: 4.4,
      reviewCount: 3211,
      category: 'Video Games',
      subcategory: 'Console',
      aboutThisItem: 'Dual Shock 4 controller',
      deliveryTimeLeft: '20hrs 36 mins',
      deliveryLocation: 'Egypt',
      inStock: true,
      shipsFrom: 'Pickpay',
      soldBy: 'Pickpay',
    );

    return ProductDetailView(product: product);
  }
}
