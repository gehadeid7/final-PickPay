import 'package:flutter/material.dart';
import 'package:pickpay/constants.dart';
import 'package:pickpay/core/utils/app_images.dart';
import 'package:pickpay/core/widgets/custom_app.dart';
import 'package:pickpay/features/home/presentation/views/widgets/categories_view_item.dart';

class CategoriesViewBody extends StatelessWidget {
  const CategoriesViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> categories = [
      {'name': 'sale', 'image': Assets.appLogo},
      {'name': 'Electronics', 'image': Assets.appLogo},
      {'name': 'Appliances', 'image': Assets.appLogo},
      {'name': 'Home', 'image': Assets.appLogo},
      {'name': 'Fashion', 'image': Assets.appLogo},
      {'name': 'Beauty', 'image': Assets.appLogo},
      {'name': 'Video games', 'image': Assets.appLogo},
      {'name': 'Toys & games', 'image': Assets.appLogo},
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          SizedBox(height: kTopPadding),
          buildAppBar(context: context, title: 'Categories'),
          const SizedBox(height: 16),
          Expanded(
            child: GridView.builder(
              itemCount: categories.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 1.1,
              ),
              itemBuilder: (context, index) {
                final category = categories[index];
                return CategoriesViewItem(
                  categoryName: category['name']!,
                  imagePath: category['image']!,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
