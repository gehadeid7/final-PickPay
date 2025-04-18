import 'package:flutter/material.dart';
import 'package:pickpay/features/home/presentation/views/widgets/sliding_featured_item.dart';

class SlidingFeaturedList extends StatelessWidget {
  const SlidingFeaturedList({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(3, (index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SlidingFeatureItem(),
          );
        }),
      ),
    );
  }
}
