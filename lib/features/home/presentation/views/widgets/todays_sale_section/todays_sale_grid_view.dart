import 'package:flutter/material.dart';
import 'package:pickpay/core/widgets/home_item.dart';

class TodaysSaleGridView extends StatelessWidget {
  const TodaysSaleGridView({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics:
          const NeverScrollableScrollPhysics(), // Important to avoid scroll conflict
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 180 / 230,
        mainAxisSpacing: 12,
        crossAxisSpacing: 16,
      ),
      itemBuilder: (context, index) => const HomeItem(),
      itemCount: 2,
    );
  }
}
