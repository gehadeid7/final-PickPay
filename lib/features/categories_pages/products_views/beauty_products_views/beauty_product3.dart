import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/products_views/product_detail_view.dart';

class BeautyProduct3 extends StatelessWidget {
  const BeautyProduct3({super.key});

  @override
  Widget build(BuildContext context) {
    final product = ProductsViewsModel(
      id: "",
      title: 'Cybele Smooth N`Wear Powder Blush Corail 17 - 3.7gm',
      imagePaths: [
        'assets/beauty_products/makeup_3/1.png',
      ],
      category: 'Beauty',
      price: 227.20,
      originalPrice: 240.00,
      rating: 5.0,
      reviewCount: 88,
      brand: 'Cybele',
      color: 'Corail 17',
      material: 'Powder',
      dimensions: '3.7 gm',
      style: 'Compact Blush',
      installationType: 'N/A',
      accessLocation: 'N/A',
      settingsCount: 0,
      powerSource: 'Manual',
      manufacturer: 'Cybele',
      aboutThisItem:
          'Smooth and long-lasting powder blush for a natural flush of color.',
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
