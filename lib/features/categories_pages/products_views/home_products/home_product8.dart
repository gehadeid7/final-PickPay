import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/products_views/product_detail_view.dart';

class HomeProduct8 extends StatelessWidget {
  const HomeProduct8({super.key});

  @override
  Widget build(BuildContext context) {
    final product = ProductsViewsModel(
      id: '681dab0df9c9147444b452d4',
      title: "glass vase 15cm",
      imagePaths: [
        'assets/Home_products/home-decor/home_decor3/1.png',
        'assets/Home_products/home-decor/home_decor3/2.png',
      ],
      price: 250.00,
      originalPrice: 300.00,
      rating: 2.8,
      reviewCount: 9,
      category: 'Home',
      subcategory: 'Home Decor',
      colorOptions: ['colorless'],
      colorAvailability: {'colorless': true},
      brand: 'Generic',
      material: 'Glass',
      dimensions: '15L x 15W x 15H centimeters',
      itemShape: 'Jar',
      style: 'Modern',
      specialfeatures: 'Stain-Resistant',
      aboutThisItem: '''Occasion type: Christmas
Material: Glass
Installation type: Tabletop''',
      deliveryDate: 'Sunday, 9 March',
      deliveryTimeLeft: '20hrs 36 mins',
      deliveryLocation: 'Egypt',
      inStock: true,
      shipsFrom: 'Pickpay',
      soldBy: 'Pickpay',
    );

    return ProductDetailView(product: product);
  }
}
