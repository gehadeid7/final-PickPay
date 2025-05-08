// lib/features/categories_pages/products_views/product7_view.dart
import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/products_views/product_detail_view.dart';

class Product7View extends StatelessWidget {
  const Product7View({super.key});

  @override
  Widget build(BuildContext context) {
    final product = ProductsViewsModel(
      id: 'elec7',
      title:
          'Xiaomi TV A 43 2025, 43", FHD, HDR, Smart Google TV with Dolby Atmos',
      imagePaths: [
        'assets/electronics_products/tvscreens/tv2/1.png',
      ],
      price: 1399.00,
      originalPrice: 1599.00,
      rating: 4.7,
      reviewCount: 1288,
      brand: "ASUS",
      color: "Eclipse Gray",
      material: "Aluminum",
      dimensions: "35.4 x 25.4 x 2.49 cm",
      style: "Gaming Laptop",
      installationType: "N/A",
      accessLocation: "N/A",
      settingsCount: 1,
      powerSource: "Battery",
      manufacturer: "ASUS",
      aboutThisItem:
          "ASUS ROG Strix, high-performance gaming laptop with AMD Ryzen 9, NVIDIA RTX 4070, 16GB RAM, and 1TB SSD. Built for serious gamers.",
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
