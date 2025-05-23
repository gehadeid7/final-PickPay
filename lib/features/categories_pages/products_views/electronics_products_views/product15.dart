import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/products_views/product_detail_view.dart';

class Product15View extends StatelessWidget {
  const Product15View({super.key});

  @override
  Widget build(BuildContext context) {
    final product = ProductsViewsModel(
      id: '6819e22b123a4faad16613c2',
      title: 'USB Cooling Pad Stand Fan Cooler for Laptop Notebook',
      imagePaths: [
        'assets/electronics_products/Laptop/Laptop5/1.png',
        'assets/electronics_products/Laptop/Laptop5/2.png',
        'assets/electronics_products/Laptop/Laptop5/3.png',
      ],
      price: 377.13,
      originalPrice: 400.15,
      rating: 3.5,
      reviewCount: 83,
      color: 'Generic',
      category: 'Electronics',
      subcategory: 'Laptop',
      brand: 'Generic',
      material: 'Plastic',
      itemWeight: '0.7 Kilograms',
      dimensions: '3.75L x 2.9W x 0.42H Meters',
      coolingMethod: 'Air',
      manufacturer: 'Generic',
      aboutThisItem:
          '''Silent Fan Protector USB Cooling Pad Stand Fan Cooler for Laptop Notebook

Silent Fan Protector USB Cooling Pad Stand Fan Cooler for Laptop Notebook

Package height: 7.8 centimeters

It works with perfection''',
      deliveryDate: 'Sunday, 9 March',
      deliveryTimeLeft: '20hrs 36 mins',
      deliveryLocation: 'Egypt',
      inStock: true,
      shipsFrom: 'Pickpay',
      soldBy: 'Pickpay',
    );

    return ProductDetailView(product: product);
  }
}
