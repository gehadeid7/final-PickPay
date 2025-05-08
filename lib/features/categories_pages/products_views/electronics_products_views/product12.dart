import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/products_views/product_detail_view.dart';

class Product12View extends StatelessWidget {
  const Product12View({super.key});

  @override
  Widget build(BuildContext context) {
    final product = ProductsViewsModel(
      id: 'elec12',
      title: 'Samsung Galaxy Tab A9 4G LTE, 8.7" Tablet, 8GB RAM, 128GB, Navy',
      imagePaths: [
        'assets/electronics_products/mobile_and_tablet/mobile_and_tablet1/1.png',
      ],
      price: 9399.00,
      originalPrice: 0.0,
      rating: 5.0,
      reviewCount: 88,
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
