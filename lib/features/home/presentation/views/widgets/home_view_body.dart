import 'package:flutter/material.dart';
import 'package:pickpay/features/home/presentation/views/widgets/custom_appbar.dart';
import 'package:pickpay/features/home/presentation/views/widgets/electronics%20_ection/electronics_grid_view.dart';
import 'package:pickpay/features/home/presentation/views/widgets/electronics%20_ection/electronics_header.dart';
import 'package:pickpay/features/home/presentation/views/widgets/recommended_section/recommended_foru_grid_view.dart';
import 'package:pickpay/features/home/presentation/views/widgets/sliding_cards_bannars/sliding_cards_feature_list.dart';
import 'package:pickpay/features/home/presentation/views/widgets/recommended_section/recommended_foru_header.dart';
import 'package:pickpay/features/home/presentation/views/widgets/todays_sale_section/todays_sale_grid_view.dart';
import 'package:pickpay/features/home/presentation/views/widgets/todays_sale_section/todays_sale_header.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      children: const [
        SizedBox(height: 12),
        CustomHomeAppbar(),
        SizedBox(height: 12),
        SlidingFeaturedList(),
        SizedBox(height: 12),
        RecommendedForuHeader(),
        SizedBox(height: 12),
        RecommendedForuGridView(),
        SizedBox(height: 12),
        ElectronicsHeader(),
        SizedBox(height: 12),
        ElectronicsGridView(),
        SizedBox(height: 12),
        TodaysSaleHeader(),
        SizedBox(height: 12),
        TodaysSaleGridView(),
      ],
    );
  }
}
