import 'package:flutter/material.dart';
import 'package:pickpay/features/home/presentation/views/card_item.dart';

class VgamesGrid extends StatelessWidget {
  const VgamesGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> games = [
      {
        'imagePath': 'assets/Categories/Electronics/samsung_galaxys23ultra.png',
        'productName': 'Samsung Galaxy S23 Ultra',
        'price': '999.99',
        'rating': 4.8,
        'reviewCount': 200,
      },
      {
        'imagePath': 'assets/Categories/Electronics/samsung_galaxys23ultra.png',
        'productName': 'Apple iPhone 15 Pro Max',
        'price': '79.99',
        'rating': 4.6,
        'reviewCount': 150,
      },
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 180 / 230,
        mainAxisSpacing: 12,
        crossAxisSpacing: 16,
      ),
      itemCount: games.length,
      itemBuilder: (context, index) {
        final game = games[index];
        return CardItem(
          imagePath: game['imagePath'],
          productName: game['productName'],
          price: game['price'],
          rating: game['rating'],
          reviewCount: game['reviewCount'],
        );
      },
    );
  }
}
