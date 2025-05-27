import 'package:flutter/material.dart';
import 'package:pickpay/features/sub_categories/home_products/Furniture.dart';
import 'package:pickpay/features/sub_categories/home_products/bath.dart';
import 'package:pickpay/features/sub_categories/home_products/home_decor.dart';
import 'package:pickpay/features/sub_categories/home_products/kitchen.dart';
import 'package:pickpay/features/sub_categories/home_products/sub_home_card.dart';

class SubhomesGrid extends StatelessWidget {
  const SubhomesGrid({super.key});

  void _navigateToCategory(BuildContext context, String categoryName) {
    Widget page;
    switch (categoryName) {
      case 'Furniture':
        page = FurnitureView();
        break;
      case 'Home Decor':
        page = HomeDecorview();
        break;
      case 'Bath & Bedding':
        page = BathView();
        break;
      case 'Kitchen & Dining':
        page = Kitchenview();
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
      {
        'name': 'Furniture',
        'image': 'assets/Home_products/furniture/furniture4/1.png'
      },
      {
        'name': 'Home Decor',
        'image': 'assets/Home_products/home-decor/home_decor4/1.png'
      },
      {
        'name': 'Bath & Bedding',
        'image': 'assets/Home_products/bath_and_bedding/bath5/3.png'
      },
      {
        'name': 'Kitchen & Dining',
        'image': 'assets/Home_products/kitchen/kitchen3/1.png'
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
          return SubHomeCard(
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
