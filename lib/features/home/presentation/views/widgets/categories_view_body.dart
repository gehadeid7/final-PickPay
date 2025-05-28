import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pickpay/constants.dart';
import 'package:pickpay/core/themes/theme_provider.dart';
import 'package:pickpay/features/home/presentation/cubits/categories_cubits/categories_cubits_cubit.dart';
import 'package:pickpay/features/home/presentation/cubits/categories_cubits/categories_cubits_state.dart';
import 'package:pickpay/features/home/presentation/views/widgets/category_navigation_helper.dart';
import 'package:pickpay/core/widgets/custom_appbar.dart';
import 'package:provider/provider.dart';
import 'package:pickpay/features/sub_categories/widgets/animated_subcategory_card.dart';

class CategoriesViewBody extends StatelessWidget {
  const CategoriesViewBody({super.key});

  Map<String, List<Map<String, dynamic>>> _getAllSubcategories(
      List<dynamic> categories) {
    final Map<String, List<Map<String, dynamic>>> categoryGroups = {
      'Home': [
        {
          'name': 'Furniture',
          'image': 'assets/Home_products/furniture/furniture4/1.png',
          'index': 5,
        },
        {
          'name': 'Home Decor',
          'image': 'assets/Home_products/home-decor/home_decor4/1.png',
          'index': 6,
        },
        {
          'name': 'Bath & Bedding',
          'image': 'assets/Home_products/bath_and_bedding/bath5/3.png',
          'index': 7,
        },
        {
          'name': 'Kitchen & Dining',
          'image': 'assets/Home_products/kitchen/kitchen3/1.png',
          'index': 8,
        },
      ],
      'Fashion': [
        {
          'name': "Women's Fashion",
          'image': 'assets/Fashion_products/Women_Fashion/women_fashion4/1.png',
          'index': 9,
        },
        {
          'name': "Men's Fashion",
          'image': 'assets/Fashion_products/Men_Fashion/men_fashion4/1.png',
          'index': 10,
        },
        {
          'name': "Kids' Fashion",
          'image': 'assets/Fashion_products/Kids_Fashion/kids_fashion4/2.png',
          'index': 11,
        },
      ],
      'Electronics': [
        {
          'name': 'Mobile & Tablets',
          'image':
              'assets/electronics_products/mobile_and_tablet/mobile_and_tablet1/1.png',
          'index': 0,
        },
        {
          'name': 'TVs',
          'image': 'assets/electronics_products/tvscreens/tv2/2.png',
          'index': 1,
        },
        {
          'name': 'Laptop',
          'image': 'assets/electronics_products/Laptop/Laptop2/1.png',
          'index': 2,
        },
      ],
      'Appliances': [
        {
          'name': 'Large Appliances',
          'image': 'assets/appliances/product3/2.png',
          'index': 3,
        },
        {
          'name': 'Small Appliances',
          'image': 'assets/appliances/product8/3.png',
          'index': 4,
        },
      ],
      'Beauty': [
        {
          'name': 'Makeup',
          'image': 'assets/beauty_products/makeup_5/1.png',
          'index': 12,
        },
        {
          'name': 'Skincare',
          'image': 'assets/beauty_products/skincare_3/1.png',
          'index': 13,
        },
        {
          'name': 'Haircare',
          'image': 'assets/beauty_products/haircare_4/1.png',
          'index': 14,
        },
        {
          'name': 'Fragrance',
          'image': 'assets/beauty_products/fragrance_2/1.png',
          'index': 15,
        },
      ],
      'Video Games': [
        {
          'name': 'Console',
          'image': 'assets/subcategories/video_games/1.png',
          'index': 16,
        },
        {
          'name': 'Controllers',
          'image': 'assets/subcategories/video_games/2.png',
          'index': 17,
        },
        {
          'name': 'Accessories',
          'image': 'assets/subcategories/video_games/3.png',
          'index': 18,
        },
      ],
    };

    return categoryGroups;
  }

  Widget _buildCategorySection(
      String title, List<Map<String, dynamic>> items, bool isDarkMode) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: isDarkMode ? Colors.white : Colors.grey.shade800,
            ),
          ),
        ),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.85,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemCount: items.length,
          itemBuilder: (context, index) {
            final subcategory = items[index];
            return AnimatedSubcategoryCard(
              name: subcategory['name'],
              imagePath: subcategory['image'],
              index: subcategory['index'],
              onTap: () => navigateToCategory(context, subcategory['name']),
            );
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: kTopPadding),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: CustomHomeAppbar(),
          ),
          BlocBuilder<CategoriesCubit, CategoriesState>(
            builder: (context, state) {
              if (state is CategoriesLoading) {
                return const Center(
                  child: CircularProgressIndicator.adaptive(),
                );
              } else if (state is CategoriesLoaded) {
                final categoryGroups = _getAllSubcategories(state.categories);

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: categoryGroups.entries.map((entry) {
                      return _buildCategorySection(
                        entry.key,
                        entry.value,
                        isDarkMode,
                      );
                    }).toList(),
                  ),
                );
              } else if (state is CategoriesError) {
                return Center(
                  child: Text(state.message),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }
}
