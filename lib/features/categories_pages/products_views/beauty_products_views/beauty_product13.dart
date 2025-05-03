import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/products_views/product_detail_view.dart';

class BeautyProduct13 extends StatelessWidget {
  const BeautyProduct13({super.key});

  @override
  Widget build(BuildContext context) {
    final product = ProductsViewsModel(
      id: "",
      title:
          'Garnier Color Naturals Permanent Crème Hair Color - 8.1 Light Ash Blonde',
      imagePaths: [
        'assets/beauty_products/haircare_3/1.png',
        'assets/beauty_products/haircare_3/2.png',
        'assets/beauty_products/haircare_3/3.png',
      ],
      category: 'Beauty',
      price: 132.00,
      originalPrice: 0.00,
      rating: 4.0,
      reviewCount: 19,
      brand: 'Garnier',
      color: 'Light Ash Blonde',
      material: 'Cream',
      dimensions: 'Box',
      style: 'Hair Color',
      installationType: 'N/A',
      accessLocation: 'N/A',
      settingsCount: 0,
      powerSource: 'N/A',
      manufacturer: 'Garnier',
      description:
          'Permanent hair color with nourishing formula for radiant, long-lasting results.',
      deliveryDate: 'Thursday, 13 March',
      deliveryTimeLeft: '18hrs 20 mins',
      deliveryLocation: 'Egypt',
      inStock: true,
      shipsFrom: 'Pickpay Warehouse',
      soldBy: 'Pickpay Official',
    );

    return ProductDetailView(product: product);
  }
}
