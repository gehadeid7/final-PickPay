import 'package:flutter/material.dart';
import 'package:pickpay/features/sub_categories/electronics/laptop_page.dart';
import 'package:pickpay/features/sub_categories/electronics/mobile_and_tablets_page.dart';
import 'package:pickpay/features/sub_categories/electronics/tvs_page.dart';
import 'package:pickpay/features/sub_categories/electronics/sub_cat_card.dart';

class SubElectronicsGrid extends StatelessWidget {
  const SubElectronicsGrid({super.key});

  void _navigateToCategory(BuildContext context, String categoryName) {
    Widget page;
    switch (categoryName) {
      case 'Mobile & Tablets':
        page = MobileAndTabletsPage();
        break;
      case 'TVs':
        page = TvsPage();
        break;
      case 'Laptop':
        page = LaptopPage();
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
        'name': 'Mobile & Tablets',
        'image':
            'assets/electronics_products/mobile_and_tablet/mobile_and_tablet1/1.png'
      },
      {
        'name': 'TVs',
        'image': 'assets/electronics_products/tvscreens/tv2/2.png'
      },
      {
        'name': 'Laptop',
        'image': 'assets/electronics_products/Laptop/Laptop2/1.png'
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
              child: SubElectronicsCard(
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
