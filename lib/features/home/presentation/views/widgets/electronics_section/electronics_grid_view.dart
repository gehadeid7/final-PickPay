import 'package:flutter/material.dart';
import 'package:pickpay/features/home/presentation/views/card_item.dart';

class ElectronicsGridView extends StatelessWidget {
  const ElectronicsGridView({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> beautyItems = [
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
      itemCount: beautyItems.length,
      itemBuilder: (context, index) {
        final item = beautyItems[index];
        return CardItem(
          imagePath: item['imagePath'],
          productName: item['productName'],
          price: item['price'],
          rating: item['rating'],
          reviewCount: item['reviewCount'],
        );
      },
    );
  }
}
