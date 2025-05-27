import 'package:flutter/material.dart';
import 'package:pickpay/features/sub_categories/beauty/fragrance.dart';
import 'package:pickpay/features/sub_categories/beauty/haircare.dart';
import 'package:pickpay/features/sub_categories/beauty/makeup.dart';
import 'package:pickpay/features/sub_categories/beauty/skincare.dart';
import 'package:pickpay/features/sub_categories/beauty/subbeauty_card.dart';

class SubbeautyGrid extends StatelessWidget {
  const SubbeautyGrid({super.key});

  void _navigateToCategory(BuildContext context, String categoryName) {
    Widget page;
    switch (categoryName) {
      case 'Makeup':
        page = Makeup();
        break;
      case 'Skincare':
        page = Skincare();
        break;
      case 'Haircare':
        page = Haircare();
        break;
      case 'Fragrance':
        page = Fragrance();
        break;

      default:
        page = const Scaffold(
          body: Center(child: Text('Category not found')),
        );
    }

    Navigator.push(context, MaterialPageRoute(builder: (_) => page));
  }

  @override
  Widget build(BuildContext context) {
    final categories = [
      {'name': 'Makeup', 'image': 'assets/beauty_products/makeup_5/1.png'},
      {'name': 'Skincare', 'image': 'assets/beauty_products/skincare_3/1.png'},
      {'name': 'Haircare', 'image': 'assets/beauty_products/haircare_4/1.png'},
      {
        'name': 'Fragrance',
        'image': 'assets/beauty_products/fragrance_2/1.png'
      },
    ];

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GridView.builder(
        shrinkWrap: true, // if inside another scroll view
        physics:
            const NeverScrollableScrollPhysics(), // disable scroll if needed
        itemCount: categories.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // 2 columns
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 0.9, // adjust based on design
        ),
        itemBuilder: (context, index) {
          final category = categories[index];
          return SubbeautyCard(
            imagePath: category['image']!,
            productName: category['name']!,
            index: index,
            onTap: () => _navigateToCategory(context, category['name']!),
          );
        },
      ),
    );
  }
}
