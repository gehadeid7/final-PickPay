import 'package:flutter/material.dart';
import 'package:pickpay/core/widgets/custom_app.dart';
import 'package:pickpay/features/checkout/presentation/views/widgets/checkout_view_body.dart';

class CheckoutView extends StatelessWidget {
  const CheckoutView({super.key});


static const routeName = 'checkout';
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: buildAppBar(context: context, title: 'Shipping'),
      body : CheckoutViewBody(),
    );
  }
}
