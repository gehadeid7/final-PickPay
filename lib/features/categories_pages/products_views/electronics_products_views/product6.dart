// lib/features/categories_pages/products_views/product6_view.dart
import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/products_views/product_detail_view.dart';

class Product6View extends StatelessWidget {
  const Product6View({super.key});

  @override
  Widget build(BuildContext context) {
    final product = ProductsViewsModel(
      title: "Lenovo IdeaPad 3 Laptop",
      imagePaths: ['assets/Categories/Electronics/samsung_galaxys23ultra.png'],
      price: 429.00,
      originalPrice: 549.00,
      category: 'Electronics',
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
      description:
          "Lenovo IdeaPad 3, 15.6-inch laptop with AMD Ryzen 5 processor, 8GB RAM, and 512GB SSD.",
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
