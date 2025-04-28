import 'package:flutter/material.dart';
import 'package:pickpay/constants.dart';
import 'package:pickpay/core/widgets/custom_app.dart';
import 'package:pickpay/features/home/presentation/views/widgets/beauty_section/beauty_grid.dart';

class BeautyViewBody extends StatelessWidget {
  const BeautyViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ListView(
        children: [
          SizedBox(height: kTopPadding),
          buildAppBar(context: context, title: 'Beauty'),
          SizedBox(height: 12),
          BeautyGrid(),
          SizedBox(height: 12),
          BeautyGrid(),
          SizedBox(height: 12),
          BeautyGrid(),
          SizedBox(height: 12),
          BeautyGrid(),
          SizedBox(height: 12),
          BeautyGrid(),
          SizedBox(height: 12),
          BeautyGrid(),
          SizedBox(height: 12),
          BeautyGrid(),
        ],
      ),
    );
  }
}
