import 'package:flutter/material.dart';
import 'package:pickpay/features/home/presentation/views/widgets/custom_appbar.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2),
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              children: [
                CustomHomeAppbar(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
