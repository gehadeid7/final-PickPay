import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/products_views/product_detail_view.dart';

class AppliancesProduct15 extends StatelessWidget {
  const AppliancesProduct15({super.key});

  @override
  Widget build(BuildContext context) {
    final product = ProductsViewsModel(
      id: "68252918a68b49cb06164212",
      title:
          'BLACK & DECKER Dough Mixer With 1000W 3-Blade Motor And 4L Stainless Steel Mixer For 600G Dough Mixer 5.76 Kilograms White/Sliver',
      imagePaths: [
        'assets/appliances/product15/1.png',
        'assets/appliances/product15/2.png',
        'assets/appliances/product15/3.png',
      ],
      price: 6799,
      originalPrice: 6978,
      rating: 4.6,
      reviewCount: 1735,
      brand: 'Black & Decker',
      color: 'White/Silver',
      material: 'Stainless Steel',
      bladeMaterial: 'Stainless Steel',
      stainlessSteelNumberofSpeeds: '6',
      dimensions: '40D x 12W x 43H',
      specialfeatures: 'Removable Bowl',
      settingsCount: 2,
      capacity: '4 Liters',
      wattage: '1000 watts',
      aboutThisItem: '''Kitchen appliance used to mix and knead dough

Consists of a large bowl and a rotating mixing attachment

Used for making bread, pizza, pasta, and other baked goods

Some models come with additional attachments for whipping, beating, and blending

Commonly used in bakeries, pizzerias, restaurants, and by home bakers''',
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
