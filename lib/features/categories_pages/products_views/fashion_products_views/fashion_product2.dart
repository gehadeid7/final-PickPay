import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/products_views/product_detail_view.dart';

class FashionProduct2 extends StatelessWidget {
  const FashionProduct2({super.key});

  @override
  Widget build(BuildContext context) {
    final product = ProductsViewsModel(
      id: '682b00c26977bd89257c0e8f',
      title: 'adidas womens ULTIMASHOW Shoes',
      imagePaths: [
        'assets/Fashion_products/Women_Fashion/women_fashion2/1.png',
        'assets/Fashion_products/Women_Fashion/women_fashion2/2.png',
        'assets/Fashion_products/Women_Fashion/women_fashion2/3.png',
      ],
      price: 2600,
      originalPrice: 2750,
      rating: 4.4,
      reviewCount: 252,
      category: 'Fashion',
      subcategory: "Women's Fashion",
      colorOptions: [
        'Power Pink',
        'Cloud White',
        'Sky Tint',
        'Core Black',
      ],
      colorAvailability: {
        'Power Pink': true,
        'Cloud White': true,
        'Sky Tint': true,
        'Core Black': false,
      },
      availableSizes: [
        '37',
        '38',
        '39',
        '40',
        '41',
        '42',
      ],
      sizeAvailability: {
        '37': false,
        '38': true,
        '39': false,
        '40': true,
        '41': false,
        '42': true,
      },
      careInstruction: 'Mesh',
      soleMaterial: 'Synthetic',
      outerMaterial: 'Mesh',
      innerMaterial: 'Manmade',
      aboutThisItem: '''Jogging shoes
Lace closure
Water Type : Hot And Cold
Textile upper
REGULAR FIT''',
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
