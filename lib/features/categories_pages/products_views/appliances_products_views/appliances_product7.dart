import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/products_views/product_detail_view.dart';

class AppliancesProduct7 extends StatelessWidget {
  const AppliancesProduct7({super.key});

  @override
  Widget build(BuildContext context) {
    final product = ProductsViewsModel(
      id: "68132a95ff7813b3d47f9dab",
      title: 'Black & Decker DCM25N-B5 Coffee Maker, Black - 1 Cup',
      imagePaths: [
        'assets/appliances/product7/1.png',
        'assets/appliances/product7/2.png',
        'assets/appliances/product7/3.png',
      ],
      category: 'Appliances',
      price: 930,
      originalPrice: 1680,
      rating: 3.1,
      reviewCount: 1288,
      brand: 'Black & Decker',
      color: 'Black',
      material: 'Porcelain, Polypropylene',
      dimensions: '6.6D x 8.4W x 5.6H centimeters',
      style: 'Modern',
      specialfeatures:
          'timer, programmable, thermal, water filter, removable tank',
      coffeeMakerType: 'Drip Coffee Machine',
      filtertype: 'Reusable',
      specialty: 'filter coffee',
      aboutThisItem: '''Very Effective.
Safe to use.
High Quality.
Add a great addition to your home.
Easy to be cleaned.''',
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
