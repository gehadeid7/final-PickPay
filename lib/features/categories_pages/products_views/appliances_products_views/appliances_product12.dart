import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/products_views/product_detail_view.dart';

class AppliancesProduct12 extends StatelessWidget {
  const AppliancesProduct12({super.key});

  @override
  Widget build(BuildContext context) {
    final product = ProductsViewsModel(
      id: "68132a95ff7813b3d47f9db0",
      title:
          'TORNADO Gas Water Heater 6 Liter, Digital, Natural Gas, Silver GHM-C06CNE-S',
      imagePaths: [
        'assets/appliances/product12/1.png',
        'assets/appliances/product12/2.png',
      ],
      category: 'Appliances',
      price: 3719,
      originalPrice: 3900,
      rating: 4.5,
      reviewCount: 12,
      brand: 'Tornado',
      color: 'Silver',
      capacity: '6 Liters',
      powerSource: 'Koldair',
      specialfeatures: 'Digital Display',
      itemWeight: '9 Kilograms',
      style: 'tank',
      pressure: '8 Bars',
      maximumpressure: '8 Bars',
      aboutThisItem: '''TORNADO Gas Water Heater 6 Liter.
Water Heater Color : Silver.
Working With Liquefied Natural Gas.''',
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
