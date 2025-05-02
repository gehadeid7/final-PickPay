import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/products_views/product_detail_view.dart';

class AppliancesProduct8 extends StatelessWidget {
  const AppliancesProduct8({super.key});

  @override
  Widget build(BuildContext context) {
    final product = ProductsViewsModel(
      title:
          'Black & Decker 1050W 2-Slice Stainless Steel Toaster, Silver/Black',
      imagePaths: [
        'assets/appliances/product8/1.png',
        'assets/appliances/product8/2.png',
        'assets/appliances/product8/3.png',
      ],
      category: 'Appliances',
      price: 2540,
      originalPrice: 2760,
      rating: 4.6,
      reviewCount: 884,
      brand: 'Black & Decker',
      color: 'Silver/Black',
      material: 'Stainless Steel',
      dimensions: 'Compact',
      style: 'Toaster',
      installationType: 'Countertop',
      accessLocation: 'Top',
      settingsCount: 2,
      powerSource: 'Electric',
      manufacturer: 'Black & Decker',
      description:
          'Compact 2-slice toaster with stainless steel housing and even toasting performance.',
      deliveryDate: 'Sunday, 9 March',
      deliveryTimeLeft: '20hrs 36 mins',
      deliveryLocation: 'Egypt',
      inStock: true,
      shipsFrom: 'Pickpay Warehouse',
      soldBy: 'Pickpay Official',
    );
    return ProductDetailView(product: product);
  }
}
