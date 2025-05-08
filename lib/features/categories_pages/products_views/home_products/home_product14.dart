import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/products_views/product_detail_view.dart';

class HomeProduct14 extends StatelessWidget {
  const HomeProduct14({super.key});

  @override
  Widget build(BuildContext context) {
    final product = ProductsViewsModel(
      id: '',
      title: "",
      imagePaths: [],
      price: 850,
      originalPrice: 900,
      rating: 3.1,
      reviewCount: 81228,
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
