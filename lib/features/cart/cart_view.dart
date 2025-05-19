import 'package:flutter/material.dart';
import 'package:pickpay/features/cart/cart_view_body.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  static const routeName = 'cart';

  @override
  Widget build(BuildContext context) {
    // Simply returning the CartViewBody widget
    return const CartViewBody();
  }
}
