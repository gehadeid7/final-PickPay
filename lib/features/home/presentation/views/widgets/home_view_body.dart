import 'package:flutter/material.dart';
import 'package:pickpay/core/widgets/home_item.dart';
import 'package:pickpay/features/home/presentation/views/widgets/custom_appbar.dart';
import 'package:pickpay/features/home/presentation/views/widgets/sliding_cards_feature_list.dart';
import 'package:pickpay/features/home/presentation/views/widgets/recommended_foru_header.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2),
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              children: [
                CustomHomeAppbar(),
                SizedBox(height: 12),
                SlidingFeaturedList(),
                SizedBox(height: 12),
                RecommendedForuHeader(),
                SizedBox(height: 12),
                HomeItem(),
              ],
            ),
=======
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Column(
            children: [
              CustomAppbar(),
              SizedBox(
                height: 24,
              ),
              SlidingCards(),
            ],
>>>>>>> 06bfb18 (Sliding Cards)
          ),
        ],
      ),
    );
  }
}
