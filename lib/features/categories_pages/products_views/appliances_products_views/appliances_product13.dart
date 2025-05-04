import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/products_views/product_detail_view.dart';

class AppliancesProduct13 extends StatelessWidget {
  const AppliancesProduct13({super.key});

  @override
  Widget build(BuildContext context) {
    final product = ProductsViewsModel(
      id: "68132a95ff7813b3d47f9db1",
      title:
          'Black & Decker 500W 1.5L Blender with Grinder Mill, White - BX520-B5',
      imagePaths: [
        'assets/appliances/product13/1.png',
        'assets/appliances/product13/2.png',
        'assets/appliances/product13/3.png',
        'assets/appliances/product13/4.png',
        'assets/appliances/product13/5.png',
      ],
      category: 'Appliances',
      price: 1299,
      originalPrice: 1450,
      rating: 4.9,
      reviewCount: 1439,
      brand: 'Black & Decker',
      color: 'White',
      material: 'Plastic and Glass',
      dimensions: '1.5L',
      style: 'Countertop Blender',
      installationType: 'N/A',
      accessLocation: 'Top',
      settingsCount: 2,
      powerSource: 'Electric',
      manufacturer: 'Black & Decker',
      aboutThisItem:
          'High-quality 500W blender with a 1.5L jar and grinder mill. Ideal for blending and grinding tasks.',
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
