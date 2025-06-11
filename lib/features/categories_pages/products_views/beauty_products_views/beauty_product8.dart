import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/products_views/product_detail_view.dart';

class BeautyProduct8 extends StatelessWidget {
  const BeautyProduct8({super.key});

  @override
  Widget build(BuildContext context) {
    final product = ProductsViewsModel(
      id: "682b00d16977bd89257c0ea4",
      title:
          'Eva Aloe skin clinic anti-ageing collagen toner for firmed and refined skin - 200ml',
      imagePaths: [
        'assets/beauty_products/skincare_3/1.png',
        'assets/beauty_products/skincare_3/2.png',
      ],
      price: 158.60,
      originalPrice: 210.00,
      rating: 4.4,
      reviewCount: 317,
      brand: 'Eva',
      category: 'Beauty',
      subcategory: 'Skincare',
      itemvolume: '200 Milliliters',
      itemform: 'Aerosol',
      itemWeight: '2 Grams',
      scent: 'Unscented',
      recommendedUsesForProduct:
          'anti-ageing skin care, facial toning, general skin care',
      skintype: 'All',
      materialfeature: 'Alcohol Free',
      productbenefit: 'Anti Aging',
      aboutThisItem: '''Brand: Eva
Type: Face.
Skin: All Skin Type
Size: 200 ml
Cleansers''',
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
