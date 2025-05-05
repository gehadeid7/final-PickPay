import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/products_views/product_detail_view.dart';

class BeautyProduct2 extends StatelessWidget {
  const BeautyProduct2({super.key});

  @override
  Widget build(BuildContext context) {
    final product = ProductsViewsModel(
      id: "",
      title:
          'L\'Oréal Paris Infaillible 24H Matte Cover Foundation 200 Sable Dore - Oil Control, High Coverage',
      imagePaths: [
        'assets/beauty_products/makeup_2/1.png',
        'assets/beauty_products/makeup_2/2.png',
        'assets/beauty_products/makeup_2/3.png',
        'assets/beauty_products/makeup_2/4.png',
      ],
      category: 'Beauty',
      price: 509.00,
      originalPrice: 575.00,
      rating: 5.0,
      reviewCount: 88,
      colorOptions: [
        '200 Sable',
        '130 Beige',
        '135 Vanil',
        '155 Natural Rose',
        '175 Sand',
        '230 Miel',
        '260 Solei',
        '320 Cool Undertone',
        'ivory Pink/Rose Ivory'
      ],
      itemform: 'Cream',
      skintype: 'All',
      brand: 'L’Oréal Paris',
      finishType: 'Matte',
      recommendedUsesForProduct: 'Brightening',
      material: 'Non-comedogenic',
      containerType: 'Tube',
      coverage: 'Full',
      productbenefit: 'Brightening',
      aboutThisItem:
          '''Waterproof foundation with maximum matte coverage that lasts all day.
           ​​
Lightweight and supernatural finish.​​

24H shine/oil Control​​

Smoothly blends with fingers​​

Color stays true the whole day ​''',
      deliveryDate: 'Sunday, 9 March',
      deliveryTimeLeft: '20hrs 36 mins',
      deliveryLocation: 'Egypt',
      inStock: false,
      shipsFrom: 'Pickpay ',
      soldBy: 'Pickpay ',
    );

    return ProductDetailView(product: product);
  }
}
