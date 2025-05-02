// lib/features/categories_pages/products_views/product5_view.dart
import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/products_views/product_detail_view.dart';

class Product5View extends StatelessWidget {
  const Product5View({super.key});

  @override
  Widget build(BuildContext context) {
    final product = ProductsViewsModel(
      title: "Apple MacBook Air M2",
      imagePaths: ['assets/Categories/Electronics/samsung_galaxys23ultra.png'],
      price: 1149.00,
      originalPrice: 1299.00,
      category: 'Electronics',
      rating: 4.8,
      reviewCount: 2123,
      brand: "Apple",
      color: "Silver",
      material: "Aluminum",
      dimensions: "30.41 x 21.24 x 1.61 cm",
      style: "Laptop",
      installationType: "N/A",
      accessLocation: "N/A",
      settingsCount: 1,
      powerSource: "Battery",
      manufacturer: "Apple",
      description:
          "Apple MacBook Air with M2 chip. 13.6-inch Retina display, up to 18 hours of battery life.",
      deliveryDate: "Wednesday, May 10th",
      deliveryTimeLeft: "2 hours 30 minutes",
      deliveryLocation: "Cairo, Egypt",
      inStock: true,
      shipsFrom: "Egypt",
      soldBy: "Apple Official Store",
    );

    return ProductDetailView(product: product);
  }
}
