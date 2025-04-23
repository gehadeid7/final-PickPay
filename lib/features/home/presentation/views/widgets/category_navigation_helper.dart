import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/appliances/presentation/views/appliances_view.dart';
import 'package:pickpay/features/categories_pages/beauty/presentation/views/beauty_view.dart';
import 'package:pickpay/features/categories_pages/electronics/presentation/views/electronics_view.dart';
import 'package:pickpay/features/categories_pages/fashion/presentation/views/fashion_view.dart';
import 'package:pickpay/features/categories_pages/homeCategory/presentation/views/home_category_view.dart';
import 'package:pickpay/features/categories_pages/todayIsSale/presentation/views/sale_view.dart';
import 'package:pickpay/features/categories_pages/toyes&games/presentation/views/toyes_view.dart';
import 'package:pickpay/features/categories_pages/videogames/presentation/views/videogames_view.dart';

void navigateToCategory(BuildContext context, String category) {
  final normalized = category.toLowerCase().trim();
  final page = _getCategoryPage(normalized);

  Navigator.push(context, MaterialPageRoute(builder: (_) => page));
}

Widget _getCategoryPage(String category) {
  switch (category) {
    case 'electronics':
      return const ElectronicsView();
    case 'sale':
      return const SaleView();
    case 'appliances':
      return const AppliancesView();
    case 'home':
      return const HomeCategoryView();
    case 'fashion':
      return const FashionView();
    case 'beauty':
      return const BeautyView();
    case 'toys & games':
      return const ToysView();
    case 'video games':
      return const VideogamesView();
    default:
      return Scaffold(
        appBar: AppBar(title: Text(category)),
        body: Center(child: Text('Page for "$category" coming soon')),
      );
  }
}
