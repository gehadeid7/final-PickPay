import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/todayIsSale/presentation/views/widgets/sale_view_body.dart';

class SaleView extends StatelessWidget {
  const SaleView({super.key});

  static const routeName = 'sale_view';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: SaleViewBody()),
    );
  }
}
