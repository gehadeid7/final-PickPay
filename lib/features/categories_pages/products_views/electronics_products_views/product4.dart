import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/products_views/product_detail_view.dart';

class Product4View extends StatelessWidget {
  const Product4View({super.key});

  @override
  Widget build(BuildContext context) {
    final product = ProductsViewsModel(
      title: "Sony WH-1000XM5 Wireless Headphones",
      imagePaths: ['assets/Categories/Electronics/samsung_galaxys23ultra.png'],
      price: 348.00,
      category: 'Electronics',
      originalPrice: 399.99,
      rating: 4.9,
      reviewCount: 3120,
      brand: "Sony",
      color: "Black",
      material: "Plastic, Memory Foam",
      dimensions: "18.4 x 7.4 x 23.9 cm",
      style: "Headphones",
      installationType: "N/A",
      accessLocation: "N/A",
      settingsCount: 1,
      powerSource: "Rechargeable Battery",
      manufacturer: "Sony",
      description: "Sony's flagship noise-cancelling wireless headphones.",
      deliveryDate: "Friday, May 8th",
      deliveryTimeLeft: "1 hour 15 minutes",
      deliveryLocation: "Cairo, Egypt",
      inStock: true,
      shipsFrom: "Egypt",
      soldBy: "Sony Official Store",
    );

    return ProductDetailView(product: product);
  }
}
