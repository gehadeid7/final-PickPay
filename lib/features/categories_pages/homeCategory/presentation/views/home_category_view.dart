import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/homeCategory/presentation/views/widgets/home_cat_view_body.dart';

class HomeCategoryView extends StatelessWidget {
  const HomeCategoryView({super.key});

  static const routeName = 'HomeCategory_View';

  @override
  Widget build(BuildContext context) {
    return HomeCategoryViewBody();
  }
}
