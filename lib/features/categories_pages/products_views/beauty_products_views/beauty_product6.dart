import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/products_views/product_detail_view.dart';

class BeautyProduct6 extends StatelessWidget {
  const BeautyProduct6({super.key});

  @override
  Widget build(BuildContext context) {
    final product = ProductsViewsModel(
      id: "",
      title: 'Care & More Soft Cream With Glycerin Mixed berries 75 ML',
      imagePaths: [
        'assets/beauty_products/skincare_1/1.png',
        'assets/beauty_products/skincare_1/2.png',
      ],
      category: 'Beauty',
      price: 31.00,
      originalPrice: 44.00,
      rating: 4.0,
      reviewCount: 19,
      brand: 'Care & More',
      color: 'White',
      material: 'Cream',
      dimensions: '75 ml',
      style: 'Moisturizing Cream',
      installationType: 'N/A',
      accessLocation: 'N/A',
      settingsCount: 0,
      powerSource: 'Manual',
      manufacturer: 'Care & More',
      description:
          'Hydrating soft cream enriched with glycerin and berry extract for dry skin.',
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
