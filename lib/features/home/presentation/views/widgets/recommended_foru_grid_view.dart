import 'package:flutter/material.dart';
import 'package:pickpay/core/widgets/home_item.dart';

class RecommendedForuGridView extends StatelessWidget {
  const RecommendedForuGridView({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      sliver: SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 180 / 230,
          mainAxisSpacing: 12,
          crossAxisSpacing: 16,
        ),
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            return const HomeItem();
          },
        ),
      ),
    );
  }
}
