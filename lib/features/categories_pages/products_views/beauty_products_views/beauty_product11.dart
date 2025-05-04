import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/products_views/product_detail_view.dart';

class BeautyProduct11 extends StatelessWidget {
  const BeautyProduct11({super.key});

  @override
  Widget build(BuildContext context) {
    final product = ProductsViewsModel(
      id: "",
      title: 'L’Oréal Paris Elvive Hyaluron Pure Shampoo 400ML',
      imagePaths: [
        'assets/beauty_products/haircare_1/1.png',
        'assets/beauty_products/haircare_1/2.png',
        'assets/beauty_products/haircare_1/3.png',
        'assets/beauty_products/haircare_1/4.png',
      ],
      category: 'Beauty',
      price: 142.20,
      originalPrice: 0.00,
      rating: 4.0,
      reviewCount: 19,
      brand: 'L’Oréal Paris',
      color: 'Clear',
      material: 'Liquid',
      dimensions: '400ml',
      style: 'Shampoo',
      installationType: 'N/A',
      accessLocation: 'N/A',
      settingsCount: 0,
      powerSource: 'N/A',
      manufacturer: 'L’Oréal Paris',
      aboutThisItem: 'Gentle purifying shampoo for oily scalp and dry ends.',
      deliveryDate: 'Tuesday, 11 March',
      deliveryTimeLeft: '20hrs 30 mins',
      deliveryLocation: 'Egypt',
      inStock: true,
      shipsFrom: 'Pickpay Warehouse',
      soldBy: 'Pickpay Official',
    );

    return ProductDetailView(product: product);
  }
}
