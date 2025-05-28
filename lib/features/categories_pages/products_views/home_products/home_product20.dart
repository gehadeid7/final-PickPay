import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/products_views/product_detail_view.dart';

class HomeProduct20 extends StatelessWidget {
  const HomeProduct20({super.key});

  @override
  Widget build(BuildContext context) {
    final product = ProductsViewsModel(
      id: '681dab0df9c9147444b452e0',
      title:
          "Home of Linen - Duvet Cover Set - 3 Pieces for Double Bed - 1 Duvet Cover (185cm*235cm) + 2 Pillow Cases (50cm*70cm) - 100% Egyptian Cotton - Zebra - 802",
      imagePaths: [
        'assets/Home_products/bath_and_bedding/bath5/1.png',
        'assets/Home_products/bath_and_bedding/bath5/2.png',
        'assets/Home_products/bath_and_bedding/bath5/3.png',
      ],
      price: 948.00,
      originalPrice: 989.00,
      rating: 3.8,
      reviewCount: 84,
      category: 'Home',
      subcategory: 'Bath & Bedding',
      color: 'Zebra',
      brand: 'Home of Linen',
      material: 'Linen',
      theme: 'Animals',
      style: 'Egyptian',
      size: 'Double',
      numberOfPieces: '3',
      includedComponents: 'Duvet Cover',
      pattern: 'Animal Print',
      productCareInstructions: 'Dry Clean Only',
      aboutThisItem: '''Duvet Cover Set

Fine Quality For Hotels and Home Décor

1 Duvet Cover (185cm*235cm) + 2 Pillow Cases (50cm*70cm)''',
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
