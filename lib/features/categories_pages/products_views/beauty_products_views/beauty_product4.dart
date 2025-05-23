import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/products_views/product_detail_view.dart';

class BeautyProduct4 extends StatelessWidget {
  const BeautyProduct4({super.key});

  @override
  Widget build(BuildContext context) {
    final product = ProductsViewsModel(
      id: "68132a95ff7813b3d47f9da4",
      title:
          'Eva skin care cleansing & makeup remover facial wipes for normal/dry skin 20%',
      imagePaths: [
        'assets/beauty_products/makeup_4/1.png',
      ],
      price: 62.00,
      originalPrice: 63.00,
      rating: 5.0,
      reviewCount: 92,
      category: 'Beauty',
      subcategory: 'Makeup',
      itemform: 'Wipes',
      skintype: 'Normal',
      brand: 'Eva',
      material: 'Allergen Free, Alcohol Free',
      specialfeatures:
          'dehydration_&_dryness, daily_care, fairness_&_brightening, Makeup Remover',
      productbenefit: 'Makeup Removal',
      unitcount: '1 Pack',
      numberofitems: '1',
      ageRangeDescription: 'Adult',
      aboutThisItem: '''wipes

Eva Skin Care Cleansing & Makeup Remover Facial Wipes For Normal/Dry Skin 20%

product_type: SKIN_CLEANING_WIPE

gl_product_group_type: gl_beauty

ASIN: B0BN469HL9''',
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
