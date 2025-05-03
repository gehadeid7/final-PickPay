import 'package:flutter/material.dart';
import 'package:pickpay/features/home/presentation/views/widgets/cart_view_body.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  static const routeName = 'Cart_View';

  @override
  Widget build(BuildContext context) {
    return CartViewBody();
  }
}
