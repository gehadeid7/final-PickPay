import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/products_views/product_detail_view.dart';

class HomeProduct18 extends StatelessWidget {
  const HomeProduct18({super.key});

  @override
  Widget build(BuildContext context) {
    final product = ProductsViewsModel(
      id: 'home18',
      title:
          "Bedsure 100% Cotton Blankets Queen Size for Bed - Waffle Weave Blankets for Summer, Lightweight and Breathable Soft Woven Blankets for Spring, Mint, 90x90 Inches",
      imagePaths: [
        'assets/Home_products/bath_and_bedding/bath3/1.png',
        'assets/Home_products/bath_and_bedding/bath3/2.png',
        'assets/Home_products/bath_and_bedding/bath3/3.png',
      ],
      price: 604.00,
      originalPrice: 635.00,
      rating: 4.4,
      reviewCount: 20938,
      brand: 'Bedsure',
      color: '03 - Mint',
      material: 'Cotton',
      specialfeatures: 'Skin Friendly',
      style: 'Modern',
      size: 'Queen',
      blanketForm: 'Single Layered Blanket',
      theme: 'Fantasy',
      pattern: 'Solid',
      ageRangeDescription: 'Adult',
      aboutThisItem:
          '''Soft, Breathable & Stylish: Made from 100% cotton, this pre-washed throw blanket features a gentle hand feel that gets even softer after washing. The anti-static fabric offers exceptional breathability and moisture absorption for a cozy and dry night's sleep all year round.

Warm Yet Lightweight: Made from premium long staple cotton, this waffle blanket has the perfect balance of warmth and weight. Ideal for snuggling up, its soft and calming fabric will make you feel comfortable and cozy.

Elevated Classic Texture: This elegant blanket features a classic waffle weave design with a distinctive three-dimensional texture that adds a touch of style to your bedroom.

Giftable: Available in multiple sizes and colors, this waffle weave blanket comes in a festive gift-ready package, making this ultra-soft blanket a great gift option.

Care Tip: For best results, tumble dry on fluff air no heat for 30 mins before washing. Machine wash separately with Woolite in cold water on a gentle cycle, and then tumble dry low for two extra cycles to restore freshness''',
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
