import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/products_views/product_detail_view.dart';

class AppliancesProduct6 extends StatelessWidget {
  const AppliancesProduct6({super.key});

  @override
  Widget build(BuildContext context) {
    final product = ProductsViewsModel(
      id: "68132a95ff7813b3d47f9daa",
      title:
          'deime Air Fryer 6.2 Quart, Large Air Fryer for Families, 5 Cooking Functions',
      imagePaths: [
        'assets/appliances/product6/1.png',
        'assets/appliances/product6/2.png',
        'assets/appliances/product6/3.png',
      ],
      category: 'Appliances',
      price: 3629,
      originalPrice: 4000,
      rating: 4.5,
      reviewCount: 954,
      brand: 'deime',
      color: 'Black',
      material: 'Ceramic Coated',
      dimensions: '6.2 Quart Capacity',
      style: 'Air Fryer',
      installationType: 'Countertop',
      accessLocation: 'Top',
      settingsCount: 5,
      powerSource: 'Electric',
      manufacturer: 'deime',
      description:
          'Large capacity air fryer with ceramic coated basket, 5 cooking presets, and temperature control.',
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
