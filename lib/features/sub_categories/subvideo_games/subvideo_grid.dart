import 'package:flutter/material.dart';
import 'package:pickpay/features/sub_categories/subvideo_games/accessories.dart';
import 'package:pickpay/features/sub_categories/subvideo_games/console.dart';
import 'package:pickpay/features/sub_categories/subvideo_games/controllers.dart';
import 'package:pickpay/features/sub_categories/subvideo_games/subvideo_card.dart';

class SubvideoGrid extends StatelessWidget {
  const SubvideoGrid({super.key});

  void _navigateToCategory(BuildContext context, String categoryName) {
    Widget page;
    switch (categoryName) {
      case 'Console':
        page = Console();
        break;
      case 'Controllers':
        page = Controllers();
        break;
      case 'Accessories':
        page = Accessories();
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
      {'name': 'Console', 'image': 'assets/subcategories/video_games/1.png'},
      {
        'name': 'Controllers',
        'image': 'assets/subcategories/video_games/2.png'
      },
      {
        'name': 'Accessories',
        'image': 'assets/subcategories/video_games/3.png'
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
                child: SubvideoCard(
                  imagePath: categories[0]['image']!,
                  productName: categories[0]['name']!,
                  index: 0,
                  onTap: () =>
                      _navigateToCategory(context, categories[0]['name']!),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: SubvideoCard(
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
              child: SubvideoCard(
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
