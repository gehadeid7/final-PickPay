import 'package:flutter/material.dart';
import 'package:pickpay/constants.dart';
import 'package:pickpay/core/widgets/custom_app.dart';
import 'package:pickpay/features/home/presentation/views/widgets/home_section/home_section_grid.dart';

class HomeCategoryViewBody extends StatelessWidget {
  const HomeCategoryViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ListView(
        children: [
          SizedBox(height: kTopPadding),
          buildAppBar(context: context, title: 'Home'),
          SizedBox(height: 12),
          HomeSectionGrid(),
          SizedBox(height: 12),
          HomeSectionGrid(),
          SizedBox(height: 12),
          HomeSectionGrid(),
          SizedBox(height: 12),
          HomeSectionGrid(),
          SizedBox(height: 12),
          HomeSectionGrid(),
          SizedBox(height: 12),
          HomeSectionGrid(),
          SizedBox(height: 12),
          HomeSectionGrid(),
        ],
      ),
    );
  }
}
