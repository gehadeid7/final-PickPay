import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/appliances/presentation/views/appliances_view.dart';
import 'package:pickpay/features/categories_pages/electronics/presentation/views/electronics_view.dart';
import 'package:pickpay/features/categories_pages/homeCategory/presentation/views/home_category_view.dart';
import 'package:pickpay/features/categories_pages/todayIsSale/presentation/views/sale_view.dart';

void navigateToCategory(BuildContext context, String category) {
  Widget page;

  switch (category.toLowerCase()) {
    case 'electronics':
      page = const ElectronicsView();
      break;
    case 'On Sale':
      page = const SaleView();
      break;
    case 'Appliances':
      page = const AppliancesView();
      break;
    case 'Home Category':
      page = const HomeCategoryView();
      break;

    // Add other cases
    default:
      page = Scaffold(
        appBar: AppBar(title: Text(category)),
        // body: Center(child: Text('Page for $category coming soon')),
      );
  }

  Navigator.push(context, MaterialPageRoute(builder: (_) => page));
}
