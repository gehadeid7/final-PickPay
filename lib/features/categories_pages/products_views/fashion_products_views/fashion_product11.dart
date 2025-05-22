import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/products_views/product_detail_view.dart';

class FashionProduct11 extends StatelessWidget {
  const FashionProduct11({super.key});

  @override
  Widget build(BuildContext context) {
    final product = ProductsViewsModel(
      id: '68132a95ff7813b3d47f9da11',
      title: "LC WAIKIKI Crew Neck Girl's Shorts Pajama Set",
      imagePaths: [
        "assets/Fashion_products/Kids_Fashion/kids_fashion1/1.png",
        "assets/Fashion_products/Kids_Fashion/kids_fashion1/2.png",
        "assets/Fashion_products/Kids_Fashion/kids_fashion1/3.png",
        "assets/Fashion_products/Kids_Fashion/kids_fashion1/4.png",
      ],
      price: 261,
      originalPrice: 349,
      rating: 4.3,
      reviewCount: 11,
      category: 'Fashion',
      subcategory: "Kids' Fashion",
      availableSizes: [
        '3-6 Months',
        '6-9 Months',
        '9-12 Months',
        '12-18 Months',
        '18-24 Months',
        '24 Months',
      ],
      sizeAvailability: {
        '3-6 Months': true,
        '6-9 Months': true,
        '9-12 Months': true,
        '12-18 Months': false,
        '18-24 Months': false,
        '24 Months': true,
      },
      careInstruction: 'Machine wash',
      closureType: 'Pull On',
      aboutThisItem: '''MAIN FABRIC: 100% Cotton

Regular

EGYPT

Crew Neck

WASH AT MAXIMUM 30 °C, DO NOT USE BLEACH, DO NOT TUMBLE DRY, IRON AT MEDIUM TEMPERATURE, DO NOT DRY CLEAN''',
      deliveryDate: 'Sunday, 9 March',
      deliveryTimeLeft: '20hrs 36 mins',
      deliveryLocation: 'Egypt',
      inStock: true,
      shipsFrom: 'Pickpay',
      soldBy: 'Pickpay ',
    );

    return ProductDetailView(product: product);
  }
}
