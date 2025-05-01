import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/products_views/product_detail_view.dart';

class Product1View extends StatelessWidget {
  const Product1View({super.key});

  @override
  Widget build(BuildContext context) {
    final product = ProductsViewsModel(
      name: 'Samsung Galaxy S23 Ultra',
      imagePaths: [
        'assets/Categories/Electronics/samsung_galaxys23ultra.png',
        'assets/Categories/Electronics/samsung_galaxys23ultra.png',
      ],
      price: 999.99,
      originalPrice: 1199.99,
      rating: 4.9,
      reviewCount: 1893,
      brand: 'Samsung',
      color: 'Phantom Black',
      material: 'Aluminum, Gorilla Glass Victus 2',
      dimensions: '163.4 x 78.1 x 8.9 mm',
      style: 'Smartphone',
      installationType: 'N/A',
      accessLocation: 'Front',
      settingsCount: 1,
      powerSource: 'Battery Powered',
      manufacturer: 'Samsung',
      description:
          'The Galaxy S23 Ultra features a 200MP main camera, Snapdragon 8 Gen 2, and a 6.8-inch QHD+ AMOLED display with S Pen support.',
    );

    return ProductDetailView(product: product);
  }
}
