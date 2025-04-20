import 'package:flutter/material.dart';
import 'package:pickpay/core/widgets/category_appbar.dart';
import 'package:pickpay/features/categories_pages/electronics/presentation/views/widgets/electronics_view_body.dart';

class ElectronicsView extends StatelessWidget {
  const ElectronicsView({super.key});
  static const routeName = 'electronics_view';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildCategoryAppBar(
        context,
        title: 'Electronics',
      ),
      body: ElectronicsViewBody(),
    );
  }
}
