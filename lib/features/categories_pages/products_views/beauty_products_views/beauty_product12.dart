import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/products_views/product_detail_view.dart';

class BeautyProduct12 extends StatelessWidget {
  const BeautyProduct12({super.key});

  @override
  Widget build(BuildContext context) {
    final product = ProductsViewsModel(
      id: "",
      title: 'Raw African Booster Shea Set',
      imagePaths: [
        'assets/beauty_products/haircare_2/1.png',
        'assets/beauty_products/haircare_2/2.png',
        'assets/beauty_products/haircare_2/3.png',
      ],
      category: 'Beauty',
      price: 650.00,
      originalPrice: 0.00,
      rating: 4.0,
      reviewCount: 19,
      brand: 'Raw African',
      color: 'N/A',
      material: 'Shea Butter',
      dimensions: 'Set',
      style: 'Hair Care Set',
      installationType: 'N/A',
      accessLocation: 'N/A',
      settingsCount: 0,
      powerSource: 'N/A',
      manufacturer: 'Raw African',
      description: 'Complete natural shea butter care for hair and scalp.',
      deliveryDate: 'Wednesday, 12 March',
      deliveryTimeLeft: '19hrs 50 mins',
      deliveryLocation: 'Egypt',
      inStock: true,
      shipsFrom: 'Pickpay Warehouse',
      soldBy: 'Pickpay Official',
    );

    return ProductDetailView(product: product);
  }
}
