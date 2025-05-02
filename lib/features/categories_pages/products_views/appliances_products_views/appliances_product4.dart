import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/products_views/product_detail_view.dart';

class AppliancesProduct4 extends StatelessWidget {
  const AppliancesProduct4({super.key});

  @override
  Widget build(BuildContext context) {
    final product = ProductsViewsModel(
      title: 'Zanussi Automatic Washing Machine, Silver, 8 KG - ZWF8240SX5r',
      imagePaths: [
        'assets/appliances/product4/1.png',
      ],
      category: 'Appliances',
      price: 17023,
      originalPrice: 19000,
      rating: 4.9,
      reviewCount: 3120,
      brand: 'Zanussi',
      color: 'Silver',
      material: 'Stainless Steel, Plastic',
      dimensions: '850 x 600 x 600 mm',
      style: 'Front Load Washing Machine',
      installationType: 'Freestanding',
      accessLocation: 'Front',
      settingsCount: 15,
      powerSource: 'Electric',
      manufacturer: 'Zanussi',
      description:
          'The Zanussi ZWF8240SX5r is an 8 KG front-load automatic washing machine offering advanced washing programs, a sleek silver finish, and energy-efficient performance ideal for daily laundry needs.',
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
