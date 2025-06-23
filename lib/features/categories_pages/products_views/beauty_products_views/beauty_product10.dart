import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/products_views/product_detail_view.dart';

class BeautyProduct10 extends StatelessWidget {
  const BeautyProduct10({super.key});

  @override
  Widget build(BuildContext context) {
    final product = ProductsViewsModel(
      id: "682b00d16977bd89257c0ea6",
      title:
          'L’Oréal Paris Hyaluron Expert Eye Serum with 2.5% Hyaluronic Acid, Caffeine and Niacinamide - 20ml',
      imagePaths: [
        'assets/beauty_products/skincare_5/1.png',
        'assets/beauty_products/skincare_5/2.png',
        'assets/beauty_products/skincare_5/3.png',
        'assets/beauty_products/skincare_5/4.png',
        'assets/beauty_products/skincare_5/5.png',
      ],
      price: 341,
      rating: 4.2,
      reviewCount: 899,
      category: 'Beauty',
      subcategory: 'Skincare',
      brand: 'L’Oréal Paris',
      itemWeight: '100 Grams',
      itemform: 'Drop',
      materialfeature: 'Cruelty Free',
      scent: 'Unscented',
      activeIngredients: 'Hyaluronic Acid, Niacinamide, Caffeine',
      skintype: 'All',
      productbenefit: 'Hydration',
      targetUseBodyPart: 'Eye',
      aboutThisItem: '''Deeply moisturizes around the eyes
      
Fills all the lines around the eyes .

Re-energizes skin

Reduces dark circles

Reduces puffiness''',
      deliveryDate: 'Monday, 10 March',
      deliveryTimeLeft: '18hrs 20 mins',
      deliveryLocation: 'Egypt',
      inStock: true,
      shipsFrom: 'Pickpay',
      soldBy: 'Pickpay',
    );

    return ProductDetailView(product: product);
  }
}
