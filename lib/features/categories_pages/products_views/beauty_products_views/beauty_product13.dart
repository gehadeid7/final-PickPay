import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/products_views/product_detail_view.dart';

class BeautyProduct13 extends StatelessWidget {
  const BeautyProduct13({super.key});

  @override
  Widget build(BuildContext context) {
    final product = ProductsViewsModel(
      id: "",
      title:
          'Garnier Color Naturals Permanent Crème Hair Color - 8.1 Light Ash Blonde',
      imagePaths: [
        'assets/beauty_products/haircare_3/1.png',
        'assets/beauty_products/haircare_3/2.png',
        'assets/beauty_products/haircare_3/3.png',
      ],
      price: 132.00,
      originalPrice: 0.00,
      rating: 4.0,
      reviewCount: 19,
      brand: 'Garnier',
      color: 'Light Ash Blonde',
      itemform: 'Cream',
      containerType: 'Bottle',
      productbenefit: 'Nourishing',
      materialfeature: 'Alcohol Free',
      hairtype: 'All',
      unitcount: '100 grams',
      numberofitems: '1',
      aboutThisItem: '''Add a dramatic splash of colour to your day

Nourishes hair and provides shiny, long lasting colour

Covers grey hair but also makes hair soft, silky and stylish

Triple protection system that seals, replenishes & conditions

Permanent nourishing hair colourant with up to 100% grey hair coverage in just 30 minutes''',
      deliveryDate: 'Thursday, 13 March',
      deliveryTimeLeft: '18hrs 20 mins',
      deliveryLocation: 'Egypt',
      inStock: true,
      shipsFrom: 'Pickpay',
      soldBy: 'Pickpay',
    );

    return ProductDetailView(product: product);
  }
}
