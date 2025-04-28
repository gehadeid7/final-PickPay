import 'package:flutter/material.dart';
import 'package:pickpay/constants.dart';
import 'package:pickpay/core/widgets/custom_app.dart';
import 'package:pickpay/features/home/presentation/views/widgets/appliances_section/appliances_grid.dart';

class AppliancesViewBody extends StatelessWidget {
  const AppliancesViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ListView(
        children: [
          SizedBox(height: kTopPadding),
          buildAppBar(context: context, title: 'Appliances'),
          SizedBox(height: 12),
          AppliancesGrid(),
          SizedBox(height: 12),
          AppliancesGrid(),
          SizedBox(height: 12),
          AppliancesGrid(),
          SizedBox(height: 12),
          AppliancesGrid(),
          SizedBox(height: 12),
          AppliancesGrid(),
          SizedBox(height: 12),
          AppliancesGrid(),
        ],
      ),
    );
  }
}
