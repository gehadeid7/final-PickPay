import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/products_views/product_detail_view.dart';

class AppliancesProduct3 extends StatelessWidget {
  const AppliancesProduct3({super.key});

  @override
  Widget build(BuildContext context) {
    final product = ProductsViewsModel(
      id: "68132a95ff7813b3d47f9da7",
      title: 'Midea Refrigerator 449L 2D TMF MDRT645MTE06E Inverter Quattro',
      imagePaths: [
        'assets/appliances/product3/1.png',
        'assets/appliances/product3/2.png',
        'assets/appliances/product3/3.png',
      ],
      category: 'Appliances',
      price: 26999,
      originalPrice: 28000,
      rating: 4.7,
      reviewCount: 1542,
      brand: 'Midea',
      color: 'Silver',
      material: 'Stainless Steel',
      dimensions: 'Height: 1770 mm, Width: 700 mm, Depth: 685 mm',
      style: 'Top Mount Freezer Refrigerator',
      installationType: 'Freestanding',
      accessLocation: 'Front',
      settingsCount: 3,
      powerSource: 'Electric',
      manufacturer: 'Midea',
      description:
          'Midea 449L Top Mount Freezer refrigerator features Inverter Quattro technology, No Frost system, Multi-Air Flow, Active-C Fresh filter, and humidity control to keep food fresher longer.',
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
