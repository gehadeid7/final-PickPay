import 'package:flutter/material.dart';
import 'package:pickpay/constants.dart';
import 'package:pickpay/core/widgets/custom_app.dart';
import 'package:pickpay/features/home/presentation/views/widgets/cart_header.dart';

class CartViewBody extends StatelessWidget {
  const CartViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: kTopPadding),
        buildAppBar(context: context, title: 'Cart'),
        SizedBox(height: 16),
        CartHeader(),
        SizedBox(height: 16),
      ],
    );
  }
}
