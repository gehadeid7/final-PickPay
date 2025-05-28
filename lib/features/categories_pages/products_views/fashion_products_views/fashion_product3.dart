import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/products_views/product_detail_view.dart';

class FashionProduct3 extends StatelessWidget {
  const FashionProduct3({super.key});

  @override
  Widget build(BuildContext context) {
    final product = ProductsViewsModel(
      id: '682b00c26977bd89257c0e90',
      title: 'American Eagle Womens Low-Rise Baggy Wide-Leg Jean',
      imagePaths: [
        'assets/Fashion_products/Women_Fashion/women_fashion3/1.png',
        'assets/Fashion_products/Women_Fashion/women_fashion3/2.png',
        // 'assets/Fashion_products/Women_Fashion/women_fashion3/3.png'
      ],
      price: 2700,
      originalPrice: 2850,
      rating: 5.0,
      reviewCount: 88,
      category: 'Fashion',
      subcategory: "Women's Fashion",
      availableSizes: [
        'XSmall',
        'Small',
        'Medium',
        'Large',
        'XLarge',
        'XXLarge'
      ],
      sizeAvailability: {
        'XSmall': false,
        'Small': true,
        'Medium': true,
        'Large': true,
        'XLarge': true,
        'XXLarge': false,
      },
      color: 'Bright Star',
      careInstruction: 'Machine Wash',
      aboutThisItem: '''Brand: American Eagle
Womens
WOMENS DENIM''',
      deliveryDate: 'Sunday, 9 March',
      deliveryTimeLeft: '20hrs 36 mins',
      deliveryLocation: 'Egypt',
      inStock: true,
      shipsFrom: 'Pickpay ',
      soldBy: 'Pickpay ',
    );

    return ProductDetailView(product: product);
  }
}
