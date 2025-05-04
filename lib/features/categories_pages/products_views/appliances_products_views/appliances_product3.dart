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
      rating: 4.5,
      reviewCount: 12,
      brand: 'Midea',
      color: 'Silver',
      capacity: '449L',
      modelNumber: 'MDRT645MTE06E',
      defrostSystem: 'No Frost',
      technology: 'Inverter Quattro',
      configration: 'Couble-Door',
      formFactor: 'Freestanding',
      energyEfficency: ' A +',
      itemWeight: '92 Kg',
      aboutThisItem:
          ''' Spacious 449L capacity refrigerator with double-door design.

Advanced Inverter Quattro technology for energy efficiency and quieter operation.

No Frost technology prevents ice buildup and eliminates the need for manual defrosting.

Multi-Air Flow system ensures even cooling throughout the refrigerator.

Active-C Fresh and Humidity Control features help keep food fresher for longer''',
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
