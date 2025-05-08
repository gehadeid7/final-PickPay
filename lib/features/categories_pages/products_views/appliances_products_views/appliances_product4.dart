import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/products_views/product_detail_view.dart';

class AppliancesProduct4 extends StatelessWidget {
  const AppliancesProduct4({super.key});

  @override
  Widget build(BuildContext context) {
    final product = ProductsViewsModel(
      id: "68132a95ff7813b3d47f9da8",
      title: 'Zanussi Automatic Washing Machine, Silver, 8 KG - ZWF8240SX5r',
      imagePaths: [
        'assets/appliances/product4/1.png',
      ],
      price: 17023,
      originalPrice: 17950,
      rating: 4.2,
      reviewCount: 14,
      brand: 'Zanussi',
      color: 'Silver',
      material: 'Stainless Steel',
      capacity: '8 KG',
      installationType: 'Freestanding',
      controlsType: 'Electronic',
      energyEfficency: 'A+++',
      spinSpeed: '1200 RPM',
      modelNumber: 'ZWF8240SX5',
      itemWeight: '71 Kg',
      aboutThisItem:
          ''' Automatic washing machine with 8 kg capacity, perfect for medium to large households.

Multiple washing programs designed for different fabric types and soil levels.

Energy-efficient design helps reduce water and electricity consumption.

Features include delay start, child lock, and easy-to-use electronic controls.

Sleek silver finish that complements any modern laundry space. ''',
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
