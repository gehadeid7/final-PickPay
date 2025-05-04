import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/products_views/product_detail_view.dart';

class AppliancesProduct15 extends StatelessWidget {
  const AppliancesProduct15({super.key});

  @override
  Widget build(BuildContext context) {
    final product = ProductsViewsModel(
      id: "68132a95ff7813b3d47f9db3",
      title:
          'BLACK & DECKER Dough Mixer With 1000W 3-Blade Motor And 4L Stainless Steel Mixer For 600G Dough Mixer 5.76 Kilograms White/Sliver',
      imagePaths: [
        'assets/appliances/product15/1.png',
        'assets/appliances/product15/2.png',
        'assets/appliances/product15/3.png',
      ],
      category: 'Appliances',
      price: 6799,
      originalPrice: 6978,
      rating: 4.6,
      reviewCount: 1735,
      brand: 'Black & Decker',
      color: 'White/Silver',
      material: 'Stainless Steel',
      dimensions: '4L Bowl, 5.76kg',
      style: 'Stand Mixer',
      installationType: 'Countertop',
      accessLocation: 'Top',
      settingsCount: 6,
      powerSource: 'Electric',
      manufacturer: 'Black & Decker',
      aboutThisItem:
          'Powerful 1000W dough mixer with 3-blade system and 4L capacity, perfect for baking and kneading tasks.',
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
