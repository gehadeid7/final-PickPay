import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/products_views/product_detail_view.dart';

class BeautyProduct20 extends StatelessWidget {
  const BeautyProduct20({super.key});

  @override
  Widget build(BuildContext context) {
    final product = ProductsViewsModel(
      id: "",
      title: 'Jacques Bogart One Man Show for Men, Eau de Toilette - 100ml',
      imagePaths: [
        'assets/beauty_products/fragrance_5/1.png',
        'assets/beauty_products/fragrance_5/2.png',
        'assets/beauty_products/fragrance_5/3.png',
        'assets/beauty_products/fragrance_5/4.png',
      ],
      category: 'Beauty',
      price: 840.00,
      originalPrice: 900.00,
      rating: 4.0,
      reviewCount: 19,
      brand: 'Jacques Bogart',
      color: 'N/A',
      material: 'Liquid',
      dimensions: '100ml',
      style: 'Eau de Toilette',
      installationType: 'N/A',
      accessLocation: 'N/A',
      settingsCount: 0,
      powerSource: 'N/A',
      manufacturer: 'Jacques Bogart',
      aboutThisItem:
          'Elegant Eau de Toilette fragrance for men with a strong, masculine scent.',
      deliveryDate: 'Friday, 21 March',
      deliveryTimeLeft: '12hrs 10 mins',
      deliveryLocation: 'Egypt',
      inStock: true,
      shipsFrom: 'Pickpay Warehouse',
      soldBy: 'Pickpay Official',
    );

    return ProductDetailView(product: product);
  }
}
