import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/products_views/product_detail_view.dart';

class Product2View extends StatelessWidget {
  const Product2View({super.key});

  @override
  Widget build(BuildContext context) {
    final product = ProductsViewsModel(
      id: '',
      title: 'Xiaomi Redmi Pad SE WiFi 11" FHD+, 8GB+256GB, Snapdragon 680',
      imagePaths: [
        'assets/electronics_products/mobile_and_tablet/mobile_and_tablet2/1.png',
      ],
      price: 12999.99,
      originalPrice: 0,
      rating: 5.0,
      reviewCount: 88,
      brand: 'Xiaomi',
      color: 'Gray',
      material: 'Metal',
      dimensions: '255 x 167 x 7.4 mm',
      style: 'Tablet',
      installationType: 'N/A',
      accessLocation: 'Front',
      settingsCount: 1,
      powerSource: 'Battery Powered',
      manufacturer: 'Xiaomi',
      aboutThisItem:
          'Redmi Pad SE with 11" FHD+ display, Snapdragon 680, 8GB RAM, and 256GB storage, ideal for media and multitasking.',
      deliveryDate: 'Monday, 10 March',
      deliveryTimeLeft: '18hrs 22 mins',
      deliveryLocation: 'Egypt',
      inStock: true,
      shipsFrom: 'Pickpay Warehouse',
      soldBy: 'Pickpay Official',
    );

    return ProductDetailView(product: product);
  }
}
