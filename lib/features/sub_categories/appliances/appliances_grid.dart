import 'package:flutter/material.dart';
import 'package:pickpay/features/sub_categories/appliances/large_appliances.dart';
import 'package:pickpay/features/sub_categories/appliances/small_appliances.dart';
import 'package:pickpay/features/sub_categories/appliances/sub_appliances_card.dart';

class SubAppliancesGrid extends StatelessWidget {
  const SubAppliancesGrid({super.key});

  void _navigateToCategory(BuildContext context, String categoryName) {
    Widget page;
    switch (categoryName) {
      case 'Large Appliances':
        page = LargeAppliances();
        break;
      case 'Small Appliances':
        page = SmallAppliances();
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
      {'name': 'Large Appliances', 'image': 'assets/appliances/product3/2.png'},
      {'name': 'Small Appliances', 'image': 'assets/appliances/product8/3.png'},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 180,
          child: categories.length <= 2
              ? Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: categories.map((category) {
                      final index = categories.indexOf(category);
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        child: SizedBox(
                          width: 140,
                          child: SubAppliancesCard(
                            imagePath: category['image']!,
                            productName: category['name']!,
                            index: index,
                            onTap: () =>
                                _navigateToCategory(context, category['name']!),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                )
              : ListView.separated(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: categories.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 12),
                  itemBuilder: (context, index) {
                    final category = categories[index];
                    return Center(
                      child: SizedBox(
                        width: 140,
                        child: SubAppliancesCard(
                          imagePath: category['image']!,
                          productName: category['name']!,
                          index: index,
                          onTap: () =>
                              _navigateToCategory(context, category['name']!),
                        ),
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }
}
