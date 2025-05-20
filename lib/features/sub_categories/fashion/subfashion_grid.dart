import 'package:flutter/material.dart';
import 'package:pickpay/features/sub_categories/electronics/sub_cat_card.dart';
import 'package:pickpay/features/sub_categories/fashion/kids.dart';
import 'package:pickpay/features/sub_categories/fashion/men.dart';
import 'package:pickpay/features/sub_categories/fashion/subfashion_card.dart';
import 'package:pickpay/features/sub_categories/fashion/women.dart';

class SubfashionGrid extends StatelessWidget {
  const SubfashionGrid({super.key});

  void _navigateToCategory(BuildContext context, String categoryName) {
    Widget page;
    switch (categoryName) {
      case "Women's fashion":
        page = const Women();
        break;
      case "Men's Fashion":
        page = const Men();
        break;
      case "Kids' Fashion":
        page = const Kids();
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
        'name': "Women's fashion",
        'image': 'assets/Fashion_products/Women_Fashion/women_fashion4/1.png'
      },
      {
        'name': "Men's Fashion",
        'image': 'assets/Fashion_products/Men_Fashion/men_fashion4/1.png'
      },
      {
        'name': "Kids' Fashion",
        'image': 'assets/Fashion_products/Kids_Fashion/kids_fashion4/2.png'
      },
    ];

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Top two side-by-side
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: SubElectronicsCard(
                  imagePath: categories[0]['image']!,
                  productName: categories[0]['name']!,
                  index: 0,
                  onTap: () =>
                      _navigateToCategory(context, categories[0]['name']!),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: SubElectronicsCard(
                  imagePath: categories[1]['image']!,
                  productName: categories[1]['name']!,
                  index: 1,
                  onTap: () =>
                      _navigateToCategory(context, categories[1]['name']!),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Centered bottom card
          Align(
            alignment: Alignment.center,
            child: SizedBox(
              width: 180,
              child: SubfashionCard(
                imagePath: categories[2]['image']!,
                productName: categories[2]['name']!,
                index: 2,
                onTap: () =>
                    _navigateToCategory(context, categories[2]['name']!),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
