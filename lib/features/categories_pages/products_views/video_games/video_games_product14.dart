import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/products_views/product_detail_view.dart';

class VideoGamesProduct14 extends StatelessWidget {
  const VideoGamesProduct14({super.key});

  @override
  Widget build(BuildContext context) {
    final product = ProductsViewsModel(
      id: 'vid14',
      title: 'EA SPORTS FC 25 Standard Edition PS5 | VideoGame | English',
      imagePaths: [
        'assets/videogames_products/Accessories/accessories5/1.png',
        'assets/videogames_products/Accessories/accessories5/2.png',
        'assets/videogames_products/Accessories/accessories5/3.png',
        'assets/videogames_products/Accessories/accessories5/4.png',
      ],
      price: 2800.00,
      originalPrice: 2900.00,
      rating: 4.5,
      reviewCount: 1530,
      category: 'Video Games',
      subcategory: 'Accessories',
      aboutThisItem:
          '''This video game is the world's leading football game; The Standard Edition contains the FC 25 full game

EA SPORTS FC 25 has the best players from the biggest clubs and competitions around the globe, with match data from the world’s top leagues powering how 19,000+ players from 700+ authentic clubs move, play, and win in every match

No matter how you choose to win in EA SPORTS FC 25, do it for the club

EA SPORTS FC 25 gives you more ways to win for the club; Team up with friends in your favorite modes with the new 5v5 Rush, and manage your club to victory as FC IQ delivers more tactical control than ever before

Get your team playing like the world’s best with FC IQ; An overhaul of tactical foundations across the game delivers greater strategic control and more realistic collective movement at the team level''',
      deliveryTimeLeft: '20hrs 36 mins',
      deliveryLocation: 'Egypt',
      inStock: true,
      shipsFrom: 'Pickpay',
      soldBy: 'Pickpay',
    );

    return ProductDetailView(product: product);
  }
}
