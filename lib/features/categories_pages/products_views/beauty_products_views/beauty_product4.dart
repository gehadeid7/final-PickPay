import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/products_views/product_detail_view.dart';

class BeautyProduct4 extends StatelessWidget {
  const BeautyProduct4({super.key});

  @override
  Widget build(BuildContext context) {
    final product = ProductsViewsModel(
      id: "",
      title:
          'Eva skin care cleansing & makeup remover facial wipes for normal/dry skin 20%',
      imagePaths: [
        'assets/beauty_products/makeup_4/1.png',
      ],
      category: 'Beauty',
      price: 63.00,
      originalPrice: 63.00,
      rating: 5.0,
      reviewCount: 92,
      brand: 'Eva',
      color: 'White',
      material: 'Wet Wipes',
      dimensions: 'Pack of 20%',
      style: 'Cleansing wipes',
      installationType: 'N/A',
      accessLocation: 'N/A',
      settingsCount: 0,
      powerSource: 'Manual',
      manufacturer: 'Eva Cosmetics',
      aboutThisItem:
          'Gently cleanses and removes makeup, suitable for normal to dry skin.',
      deliveryDate: 'Sunday, 9 March',
      deliveryTimeLeft: '20hrs 36 mins',
      deliveryLocation: 'Egypt',
      inStock: true,
      shipsFrom: 'Pickpay Warehouse',
      soldBy: 'Pickpay Official',
    );

    return ProductDetailView(product: product);
  }
}
