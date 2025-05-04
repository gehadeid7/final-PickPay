import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/products_views/product_detail_view.dart';

class BeautyProduct15 extends StatelessWidget {
  const BeautyProduct15({super.key});

  @override
  Widget build(BuildContext context) {
    final product = ProductsViewsModel(
      id: "",
      title:
          'CORATED Heatless Curling Rod Headband Kit with Clips and Scrunchie',
      imagePaths: [
        'assets/beauty_products/haircare_5/1.png',
        // 'assets/beauty_products/haircare_5/2.png',
        // 'assets/beauty_products/haircare_5/3.png',
        'assets/beauty_products/haircare_5/4.png',
      ],
      category: 'Beauty',
      price: 94.96,
      originalPrice: 111.98,
      rating: 4.0,
      reviewCount: 19,
      brand: 'CORATED',
      color: 'Pink',
      material: 'Silk',
      dimensions: 'Kit',
      style: 'Curling Tool',
      installationType: 'Manual',
      accessLocation: 'N/A',
      settingsCount: 0,
      powerSource: 'None',
      manufacturer: 'CORATED',
      aboutThisItem:
          'Gentle heatless curling kit for creating soft, bouncy curls without damage.',
      deliveryDate: 'Saturday, 15 March',
      deliveryTimeLeft: '16hrs 10 mins',
      deliveryLocation: 'Egypt',
      inStock: true,
      shipsFrom: 'Pickpay Warehouse',
      soldBy: 'Pickpay Official',
    );

    return ProductDetailView(product: product);
  }
}
