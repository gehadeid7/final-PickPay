import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/fashion/presentation/views/widgets/fashion_view.body.dart';

class FashionView extends StatelessWidget {
  const FashionView({super.key});

  static const routeName = 'fashion_view';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: FashionViewBody()),
    );
  }
}
