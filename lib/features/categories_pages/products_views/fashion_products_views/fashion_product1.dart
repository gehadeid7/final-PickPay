import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/products_views/product_detail_view.dart';

class FashionProduct1 extends StatelessWidget {
  const FashionProduct1({super.key});

  @override
  Widget build(BuildContext context) {
    final product = ProductsViewsModel(
      id: '',
      title: '',
      imagePaths: [
        '',
      ],
      category: 'Fashion',
      price: 9399.00,
      originalPrice: 0.0,
      rating: 5.0,
      reviewCount: 88,
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
