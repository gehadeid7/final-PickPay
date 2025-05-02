import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/products_views/product_detail_view.dart';

class AppliancesProduct7 extends StatelessWidget {
  const AppliancesProduct7({super.key});

  @override
  Widget build(BuildContext context) {
    final product = ProductsViewsModel(
      title: 'Black & Decker DCM25N-B5 Coffee Maker, Black - 1 Cup',
      imagePaths: [
        'assets/appliances/product7/1.png',
        'assets/appliances/product7/2.png',
        'assets/appliances/product7/3.png',
      ],
      category: 'Appliances',
      price: 930,
      originalPrice: 1200,
      rating: 4.7,
      reviewCount: 1288,
      brand: 'Black & Decker',
      color: 'Black',
      material: 'Plastic',
      dimensions: 'Compact',
      style: 'Coffee Maker',
      installationType: 'Countertop',
      accessLocation: 'Front',
      settingsCount: 1,
      powerSource: 'Electric',
      manufacturer: 'Black & Decker',
      description:
          'Single cup coffee maker, compact design ideal for personal use.',
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
