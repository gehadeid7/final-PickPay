import 'package:flutter/material.dart';
import 'package:pickpay/constants.dart';
import 'package:pickpay/core/widgets/custom_app.dart';
import 'package:pickpay/core/widgets/custom_button.dart';
import 'package:pickpay/features/checkout/presentation/views/checkout_view.dart';
import 'package:pickpay/features/home/presentation/views/widgets/cart_header.dart';
import 'package:pickpay/features/home/presentation/views/widgets/cart_items_list.dart';

class CartViewBody extends StatelessWidget {
  const CartViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                children: [
                  SizedBox(height: kTopPadding),
                  buildAppBar(context: context, title: 'Cart'),
                  SizedBox(height: 6),
                  CartHeader(),
                ],
              ),
            ),
            // SliverToBoxAdapter(child: CustomDivder()),
            // CartItemsList(
            //   cartItems: [],
            // ),
            // SliverToBoxAdapter(child: CustomDivder()),
          ],
        ),
        Positioned(
          left: 16,
          right: 16,
          bottom: MediaQuery.sizeOf(context).height * .02,
          child: CustomButton(
              onPressed: () {
                Navigator.pushNamed(context, CheckoutView.routeName);
              },
              buttonText: 'Checkout'),
        ),
      ],
    );
  }
}
