import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/toyes&games/presentation/views/widgets/toyes_view_body.dart';

class ToysView extends StatelessWidget {
  const ToysView({super.key});

  static const routeName = 'toyes_view';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: ToyesViewBody()),
    );
  }
}
