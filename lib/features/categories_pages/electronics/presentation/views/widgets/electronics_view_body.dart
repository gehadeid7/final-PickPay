import 'package:flutter/material.dart';
import 'package:pickpay/constants.dart';
import 'package:pickpay/core/widgets/custom_app.dart';
import 'package:pickpay/features/home/presentation/views/widgets/electronics_section/electronics_grid_view.dart';

class ElectronicsViewBody extends StatelessWidget {
  const ElectronicsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context: context, title: 'Electronics'),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        children: const [
          SizedBox(height: kTopPadding),
          ElectronicsGridView(),
        ],
      ),
    );
  }
}
