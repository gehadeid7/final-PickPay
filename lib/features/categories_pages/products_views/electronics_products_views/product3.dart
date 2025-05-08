import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/products_views/product_detail_view.dart';

class Product3View extends StatelessWidget {
  const Product3View({super.key});

  @override
  Widget build(BuildContext context) {
    final product = ProductsViewsModel(
      id: 'electronics_product3',
      title: "Apple iPhone 16 (128GB) - Ultramarine",
      imagePaths: [
        'assets/electronics_products/mobile_and_tablet/mobile_and_tablet3/1.png',
      ],
      price: 57555.00,
      originalPrice: 0,
      rating: 5.0,
      reviewCount: 88,
      brand: "Apple",
      color: "Ultramarine",
      material: "Aluminum and Glass",
      dimensions: "146.7 x 71.5 x 7.8 mm",
      style: "Smartphone",
      installationType: "Handheld",
      accessLocation: "Front",
      settingsCount: 1,
      powerSource: "Built-in Rechargeable Battery",
      manufacturer: "Apple Inc.",
      aboutThisItem:
          "Apple iPhone 16 with 128GB storage, A17 chip, and advanced camera system. Featuring an ultramarine finish with all-day battery life.",
      deliveryDate: "Monday, May 5th",
      deliveryTimeLeft: "2 hours 30 minutes",
      deliveryLocation: "Cairo, Egypt",
      inStock: true,
      shipsFrom: "Egypt",
      soldBy: "Apple Authorized Reseller",
    );

    return ProductDetailView(product: product);
  }
}
