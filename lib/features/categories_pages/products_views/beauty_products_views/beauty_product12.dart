import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/products_views/product_detail_view.dart';

class BeautyProduct12 extends StatelessWidget {
  const BeautyProduct12({super.key});

  @override
  Widget build(BuildContext context) {
    final product = ProductsViewsModel(
      id: "68132a95ff7813b3d47f9da12",
      title: 'Raw African Booster Shea Set',
      imagePaths: [
        'assets/beauty_products/haircare_2/1.png',
        'assets/beauty_products/haircare_2/2.png',
        'assets/beauty_products/haircare_2/3.png',
      ],
      price: 649,
      originalPrice: 700,
      rating: 5.0,
      reviewCount: 1999,
      brand: 'Raw African',
      itemWeight: '1 Kilograms',
      itemform: 'Oil',
      activeIngredients: 'Essential Oils',
      material: 'Dye Free',
      scent: 'Unscented',
      recommendedUsesForProduct: 'Hair Growth',
      unitcount: '1.0 count',
      numberofitems: '2',
      aboutThisItem: '''Brand: raw african
Item form: Oil
Scent: Unscented''',
      deliveryDate: 'Wednesday, 12 March',
      deliveryTimeLeft: '19hrs 50 mins',
      deliveryLocation: 'Egypt',
      inStock: true,
      shipsFrom: 'Pickpay',
      soldBy: 'Pickpay',
    );

    return ProductDetailView(product: product);
  }
}
