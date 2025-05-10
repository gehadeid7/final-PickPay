import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/products_views/product_detail_view.dart';

class HomeProduct2 extends StatelessWidget {
  const HomeProduct2({super.key});

  @override
  Widget build(BuildContext context) {
    final product = ProductsViewsModel(
      id: 'home2',
      title: "Star Bags Bean Bag Chair - Purple, 95*95*97 cm, Unisex Adults",
      imagePaths: [
        'assets/Home_products/furniture/furniture2/1.png',
        'assets/Home_products/furniture/furniture2/2.png',
      ],
      price: 1699.00,
      originalPrice: 1800.00,
      rating: 5.0,
      reviewCount: 1,
      colorOptions: ['Purple'],
      colorAvailability: {'Purple': true},
      pattern: 'Solid',
      brand: 'Generic',
      dimensions: '95D x 97W x 95H centimeters',
      style: 'Contemporary',
      specialfeatures:
          'Washable - Easy To Clean - Adds Decorative Touch - Excellent Size - Makes You Relax',
      material: 'Plush',
      fillMaterial: 'Foam',
      fabricType: 'Foam',
      aboutThisItem:
          '''Modern design with reasonable space to ensure no space waste.

Premium materials, foam bean filling, and plush outer material.

Lightweight and easy to travel in your home and garden.

Easy to clean and very practical to meet your needs.

Adds a decorative touch to your space and makes you feel new.

Suitable for home, work, villa, garden, cafe, mall, clinic, all outdoor and indoors.''',
      includedComponents: 'Chair includes insert',
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
