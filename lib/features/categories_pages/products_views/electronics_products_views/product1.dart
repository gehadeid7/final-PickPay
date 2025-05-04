import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/products_views/product_detail_view.dart';

class Product1View extends StatelessWidget {
  const Product1View({super.key});

  @override
  Widget build(BuildContext context) {
    final product = ProductsViewsModel(
      id: 'product1',
      title: 'Samsung Galaxy Tab A9 4G LTE, 8.7" Tablet, 8GB RAM, 128GB, Navy',
      imagePaths: [
        'assets/electronics_products/mobile_and_tablet/mobile_and_tablet1/1.png',
      ],
      category: 'Electronics',
      price: 9399.00,
      originalPrice: 0.0,
      rating: 5.0,
      reviewCount: 88,
      brand: 'Samsung',
      color: 'Navy',
      material: 'Aluminum',
      dimensions: '211 x 124.7 x 8 mm',
      style: 'Tablet',
      installationType: 'N/A',
      accessLocation: 'Front',
      settingsCount: 1,
      powerSource: 'Battery Powered',
      manufacturer: 'Samsung',
      aboutThisItem:
          'Samsung Galaxy Tab A9 offers an immersive 8.7-inch display, 8GB RAM, and 128GB storage with LTE connectivity. Ideal for entertainment, work, and everyday use.',
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
