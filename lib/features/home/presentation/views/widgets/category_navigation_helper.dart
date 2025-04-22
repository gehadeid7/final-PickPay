import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/electronics/presentation/views/electronics_view.dart';

void navigateToCategory(BuildContext context, String category) {
  Widget page;

  switch (category.toLowerCase()) {
    case 'electronics':
      page = const ElectronicsView();
      break;
    // case 'fashion':
    //   page = const FashionView();
    //   break;
    // Add other cases
    default:
      page = Scaffold(
        appBar: AppBar(title: Text(category)),
        body: Center(child: Text('Page for $category coming soon')),
      );
  }

  Navigator.push(context, MaterialPageRoute(builder: (_) => page));
}
