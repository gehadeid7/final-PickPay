import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/products_views/product_detail_view.dart';

class Product7View extends StatelessWidget {
  const Product7View({super.key});

  @override
  Widget build(BuildContext context) {
    final product = ProductsViewsModel(
      id: '',
      title: "ASUS ROG Strix Gaming Laptop",
      imagePaths: ['assets/Categories/Electronics/samsung_galaxys23ultra.png'],
      price: 1399.00,
      originalPrice: 1599.00,
      rating: 4.7,
      reviewCount: 1288,
      category: 'Electronics',
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
      description:
          "ASUS ROG Strix, high-performance gaming laptop with AMD Ryzen 9, NVIDIA RTX 4070, 16GB RAM, and 1TB SSD.",
      deliveryDate: "Thursday, May 11th",
      deliveryTimeLeft: "3 hours 5 minutes",
      deliveryLocation: "Cairo, Egypt",
      inStock: true,
      shipsFrom: "Egypt",
      soldBy: "ASUS Official Store",
    );

    return ProductDetailView(product: product);
  }
}
