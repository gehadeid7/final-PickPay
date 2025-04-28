import 'package:flutter/material.dart';
import 'package:pickpay/constants.dart';
import 'package:pickpay/core/widgets/custom_app.dart';
import 'package:pickpay/features/home/presentation/views/widgets/Fashion_section/fashion_grid.dart';

class FashionViewbody extends StatelessWidget {
  const FashionViewbody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ListView(
        children: [
          SizedBox(height: kTopPadding),
          buildAppBar(context: context, title: 'FASHION'),
          SizedBox(height: 12),
          FashionGrid(),
          SizedBox(height: 12),
          FashionGrid(),
          SizedBox(height: 12),
          FashionGrid(),
          SizedBox(height: 12),
          FashionGrid(),
          SizedBox(height: 12),
          FashionGrid(),
          SizedBox(height: 12),
          FashionGrid(),
        ],
      ),
    );
  }
}
