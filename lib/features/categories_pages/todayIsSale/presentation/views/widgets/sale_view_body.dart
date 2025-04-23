import 'package:flutter/material.dart';
import 'package:pickpay/constants.dart';
import 'package:pickpay/core/widgets/custom_app.dart';

class SaleViewBody extends StatelessWidget {
  const SaleViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SizedBox(height: kTopPadding),
        buildAppBar(context: context, title: 'ON SALE')
      ],
    );
  }
}
