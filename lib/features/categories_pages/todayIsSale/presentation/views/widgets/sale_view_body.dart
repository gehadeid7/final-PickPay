import 'package:flutter/material.dart';
import 'package:pickpay/constants.dart';
import 'package:pickpay/core/widgets/custom_app.dart';
import 'package:pickpay/features/home/presentation/views/widgets/Fashion_section/fashion_grid.dart';
import 'package:pickpay/features/home/presentation/views/widgets/appliances_section/appliances_grid.dart';
import 'package:pickpay/features/home/presentation/views/widgets/electronics_section/electronics_grid_view.dart';
import 'package:pickpay/features/home/presentation/views/widgets/home_section/home_section_grid.dart';

class SaleViewBody extends StatelessWidget {
  const SaleViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ListView(
        children: [
          SizedBox(height: kTopPadding),
          buildAppBar(context: context, title: 'ON SALE'),
          SizedBox(height: 12),
          ElectronicsGridView(products: []),
          SizedBox(height: 12),
          AppliancesGrid(),
          SizedBox(height: 12),
          HomeSectionGrid(),
          SizedBox(height: 12),
          FashionGrid(),
          SizedBox(height: 12),
        ],
      ),
    );
  }
}
