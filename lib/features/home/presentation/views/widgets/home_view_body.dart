import 'package:flutter/material.dart';
import 'package:pickpay/features/home/presentation/views/widgets/custom_appbar.dart';
import 'package:pickpay/features/home/presentation/views/widgets/sliding_cards.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Column(
            children: [
              CustomAppbar(),
            ],
          ),
        ),
      ],
    );
  }
}
