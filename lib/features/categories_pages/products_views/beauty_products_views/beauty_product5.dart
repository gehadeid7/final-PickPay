import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/products_views/product_detail_view.dart';

class BeautyProduct5 extends StatelessWidget {
  const BeautyProduct5({super.key});

  @override
  Widget build(BuildContext context) {
    final product = ProductsViewsModel(
      id: "",
      title: 'Maybelline New York Lifter Lip Gloss, 005 Petal',
      imagePaths: [
        'assets/beauty_products/makeup_5/1.png',
        'assets/beauty_products/makeup_5/2.png',
        'assets/beauty_products/makeup_5/3.png',
        'assets/beauty_products/makeup_5/4.png',
        // 'assets/beauty_products/makeup_5/5.png',
      ],
      category: 'Beauty',
      price: 300.00,
      originalPrice: 310.00,
      rating: 5.0,
      reviewCount: 88,
      brand: 'Maybelline New York',
      color: '005 Petal',
      material: 'Gloss',
      dimensions: 'Standard Size',
      style: 'Lifter Gloss',
      installationType: 'N/A',
      accessLocation: 'N/A',
      settingsCount: 0,
      powerSource: 'Manual',
      manufacturer: 'Maybelline',
      aboutThisItem:
          'Hydrating lip gloss with hyaluronic acid for a fuller, lifted look.',
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
