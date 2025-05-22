import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/products_views/product_detail_view.dart';

class AppliancesProduct13 extends StatelessWidget {
  const AppliancesProduct13({super.key});

  @override
  Widget build(BuildContext context) {
    final product = ProductsViewsModel(
      id: "68252918a68b49cb06164210",
      title:
          'Black & Decker 500W 1.5L Blender with Grinder Mill, White - BX520-B5',
      imagePaths: [
        'assets/appliances/product13/1.png',
        'assets/appliances/product13/2.png',
        'assets/appliances/product13/3.png',
        'assets/appliances/product13/4.png',
        'assets/appliances/product13/5.png',
      ],
      price: 1299,
      originalPrice: 1450,
      rating: 4.9,
      reviewCount: 1439,
      brand: 'Black & Decker',
      color: 'White',
      specialfeatures: 'Portable',
      capacity: '1.5 Liters',
      dimensions: '30D x 20W x 30H centimeters',
      material: 'Stainless Steel',
      components: 'Juice Container',
      style: 'Modern',
      powerSource: 'Corded Electric',
      recommendedUsesForProduct: 'Crushing',
      aboutThisItem:
          '''500W Powerful motor for on demand blending and grinding applicationsr.

2 Speed control + Pulse to suit different ingredients.

Durable stainless-steel blades for blending tough ingredients.

Ice Crushing flexibility for making perfect slushy drinks.

60g Grinding mill for coffee, herbs & spices.''',
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
