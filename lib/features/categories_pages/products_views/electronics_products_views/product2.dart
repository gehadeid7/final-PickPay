import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/products_views/product_detail_view.dart';

class Product2View extends StatelessWidget {
  const Product2View({super.key});

  @override
  Widget build(BuildContext context) {
    final product = ProductsViewsModel(
      id: '',
      title: "Apple iPhone 15 Pro Max",
      imagePaths: ['assets/Categories/Electronics/samsung_galaxys23ultra.png'],
      price: 1099.00,
      category: 'Electronics',
      originalPrice: 1299.00,
      rating: 4.8,
      reviewCount: 2762,
      brand: "Apple",
      color: "Space Black",
      material: "Glass, Ceramic Shield",
      dimensions: "160.8 x 78.1 x 7.85 mm",
      style: "Smartphone",
      installationType: "N/A",
      accessLocation: "Front",
      settingsCount: 1,
      powerSource: "Battery Powered",
      manufacturer: "Apple",
      description:
          "The iPhone 15 Pro Max features a 48MP main camera, A17 Pro chip, and a 6.7-inch Super Retina display.",
      deliveryDate: 'Monday, 10 March',
      deliveryTimeLeft: '18hrs 20 mins',
      deliveryLocation: 'Egypt',
      inStock: true,
      shipsFrom: 'Pickpay ',
      soldBy: 'Pickpay Official',
    );

    return ProductDetailView(product: product);
  }
}
