// lib/features/categories_pages/products_views/product6_view.dart
import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/products_views/product_detail_view.dart';

class Product6View extends StatelessWidget {
  const Product6View({super.key});

  @override
  Widget build(BuildContext context) {
    final product = ProductsViewsModel(
      id: '',
      title:
          "Samsung 55 Inch QLED Smart TV Neural HDR Quantum Processor Lite 4K - QA55QE1DAUXEG [2024 Model]",
      imagePaths: [
        'assets/electronics_products/tvscreens/tv1/1.png',
      ],
      price: 18499.00,
      originalPrice: 19477.00,
      rating: 4.5,
      reviewCount: 954,
      brand: "Lenovo",
      color: "Platinum Grey",
      material: "Plastic",
      dimensions: "32.4 x 22.4 x 1.99 cm",
      style: "Laptop",
      installationType: "N/A",
      accessLocation: "N/A",
      settingsCount: 1,
      powerSource: "Battery",
      manufacturer: "Lenovo",
      aboutThisItem:
          "Lenovo IdeaPad 3, 15.6-inch laptop with AMD Ryzen 5 processor, 8GB RAM, and 512GB SSD. Ideal for work, study, and entertainment.",
      deliveryDate: "Thursday, May 11th",
      deliveryTimeLeft: "3 hours 5 minutes",
      deliveryLocation: "Cairo, Egypt",
      inStock: true,
      shipsFrom: "Egypt",
      soldBy: "Lenovo Official Store",
    );

    return ProductDetailView(product: product);
  }
}
