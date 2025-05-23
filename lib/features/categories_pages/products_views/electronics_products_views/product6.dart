// lib/features/categories_pages/products_views/product6_view.dart
import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/products_views/product_detail_view.dart';

class Product6View extends StatelessWidget {
  const Product6View({super.key});

  @override
  Widget build(BuildContext context) {
    final product = ProductsViewsModel(
      id: '6819e22b123a4faad16613c4',
      title:
          "Samsung 55 Inch QLED Smart TV Neural HDR Quantum Processor Lite 4K - QA55QE1DAUXEG [2024 Model]",
      imagePaths: [
        'assets/electronics_products/tvscreens/tv1/1.png',
        'assets/electronics_products/tvscreens/tv1/2.png',
        'assets/electronics_products/tvscreens/tv1/3.png',
      ],
      price: 23499.00,
      originalPrice: 24999.00,
      rating: 4.5,
      reviewCount: 46,
      category: 'Electronics',
      subcategory: "TVs",
      screenSize: '55 Inches',
      brand: 'SAMSUNG',
      displayTechnology: 'QLED',
      resolution: '4K',
      refreshRate: '60',
      specialfeatures: 'Neural HDR',
      includedComponents: 'Television',
      connectivityTechnology: 'Wi-Fi',
      aspectRatio: '16:9',
      dimensions: '2D x 170W x 100H centimeters',
      aboutThisItem:
          "Samsung 55 Inch QLED Smart TV Neural HDR Quantum Processor Lite 4K - QA55QE1DAUXEG [2024 Model]",
      deliveryDate: "Thursday, May 11th",
      deliveryTimeLeft: "3 hours 5 minutes",
      deliveryLocation: "Cairo, Egypt",
      inStock: true,
      shipsFrom: "PickPay",
      soldBy: "PickPay",
    );

    return ProductDetailView(product: product);
  }
}
