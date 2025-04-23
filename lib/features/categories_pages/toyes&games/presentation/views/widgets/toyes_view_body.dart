import 'package:flutter/material.dart';
import 'package:pickpay/constants.dart';
import 'package:pickpay/core/widgets/custom_app.dart';

class ToyesViewBody extends StatelessWidget {
  const ToyesViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SizedBox(height: kTopPadding),
        buildAppBar(context: context, title: 'Toyes & Games')
      ],
    );
  }
}
