import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/products_views/product_detail_view.dart';

class FashionProduct5 extends StatelessWidget {
  const FashionProduct5({super.key});

  @override
  Widget build(BuildContext context) {
    final product = ProductsViewsModel(
      id: '68132a95ff7813b3d47f9da5',
      title: '"Aldo Caraever Ladies Satchel Handbags, Khaki, Khaki"',
      imagePaths: [
        "assets/Fashion_products/Women_Fashion/women_fashion5/1.png",
        "assets/Fashion_products/Women_Fashion/women_fashion5/2.png",
        "assets/Fashion_products/Women_Fashion/women_fashion5/3.png",
        "assets/Fashion_products/Women_Fashion/women_fashion5/4.png",
      ],
      price: 5190,
      originalPrice: 5240,
      rating: 5.0,
      reviewCount: 88,
      careInstruction: 'Hand Wash Only',
      closureType: 'Zipper',
      aboutThisItem:
          '''Bold statement design with contrasting trim and animal print accents

Zipper closure for secure storage

Removable strap for versatile styling options

Made from synthetic and mixed materials with metal hardware

Stylish and functional for any occasion''',
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
