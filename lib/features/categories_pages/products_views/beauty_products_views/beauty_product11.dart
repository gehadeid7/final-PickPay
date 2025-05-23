import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/products_views/product_detail_view.dart';

class BeautyProduct11 extends StatelessWidget {
  const BeautyProduct11({super.key});

  @override
  Widget build(BuildContext context) {
    final product = ProductsViewsModel(
      id: "68132a95ff7813b3d47f9da11",
      title: 'L’Oréal Paris Elvive Hyaluron Pure Shampoo 400ML',
      imagePaths: [
        'assets/beauty_products/haircare_1/1.png',
        'assets/beauty_products/haircare_1/2.png',
        'assets/beauty_products/haircare_1/3.png',
        'assets/beauty_products/haircare_1/4.png',
      ],
      price: 142.20,
      originalPrice: 0.00,
      rating: 4.4,
      reviewCount: 93,
      category: 'Beauty',
      subcategory: 'Haircare',
      brand: 'L’Oréal Paris',
      hairtype: 'Oily',
      itemform: 'Liquid',
      ageRangeDescription: 'Adult',
      scent: 'Unscented',
      liquidVolume: '400 Milliliters',
      recommendedUsesForProduct: 'Scalp',
      productbenefit: 'Moisturizing',
      numberofitems: '1',
      aboutThisItem: '''Suitable for all hair types, but designed for oily hair.

Suitable for all hair types, but designed for oily hair.

Enjoy clean roots and moisturized ends that last up to 72 hours, and a fresh and breathable scalp after two weeks

L’Oréal Paris Shampoo

Helps to give an even fuller hair''',
      deliveryDate: 'Tuesday, 11 March',
      deliveryTimeLeft: '20hrs 30 mins',
      deliveryLocation: 'Egypt',
      inStock: true,
      shipsFrom: 'Pickpay',
      soldBy: 'Pickpay',
    );

    return ProductDetailView(product: product);
  }
}
