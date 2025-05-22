import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/products_views/product_detail_view.dart';

class FashionProduct1 extends StatelessWidget {
  const FashionProduct1({super.key});

  @override
  Widget build(BuildContext context) {
    final product = ProductsViewsModel(
      id: '68132a95ff7813b3d47f9da1',
      title: "Women's Chiffon Lining Batwing Sleeve Dress",
      imagePaths: [
        'assets/Fashion_products/Women_Fashion/women_fashion1/1.png',
        'assets/Fashion_products/Women_Fashion/women_fashion1/2.png',
        'assets/Fashion_products/Women_Fashion/women_fashion1/1.png',
      ],
      price: 850,
      category: 'Fashion',
      subcategory: "Women's Fashion",
      originalPrice: 900,
      rating: 3.1,
      reviewCount: 81228,
      availableSizes: ['XSmall', 'Small', 'Medium', 'XLarge', 'XXLarge'],
      sizeAvailability: {
        'XSmall': true,
        'Small': true,
        'Medium': false,
        'XLarge': true,
        'XXLarge': false,
      },
      color: 'Black',
      careInstruction: 'Machine washable',
      closureType: 'Zipper',
      aboutThisItem: "Women's Chiffon Dress with Flared Sleeve Lining",
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
