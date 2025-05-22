import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/products_views/product_detail_view.dart';

class FashionProduct15 extends StatelessWidget {
  const FashionProduct15({super.key});

  @override
  Widget build(BuildContext context) {
    final product = ProductsViewsModel(
      id: '68132a95ff7813b3d47f9da15',
      title: "MIX & MAX, Ballerina Shoes, girls, Ballet Flat",
      imagePaths: [
        "assets/Fashion_products/Kids_Fashion/kids_fashion5/1.png",
        "assets/Fashion_products/Kids_Fashion/kids_fashion5/2.png",
        "assets/Fashion_products/Kids_Fashion/kids_fashion5/3.png",
      ],
      price: 354.65,
      originalPrice: 429.00,
      rating: 5.0,
      reviewCount: 19,
      category: 'Fashion',
      subcategory: "Kids' Fashion",
      colorOptions: [
        'White',
        'Beige',
        'Black',
        'Red',
        'Multicolor',
        'Rose',
      ],
      colorAvailability: {
        'White': true,
        'Beige': true,
        'Black': true,
        'Red': false,
        'Multicolor': true,
        'Rose': false,
      },
      availableSizes: [
        '0-6 Months',
        '6-12 Months',
        '12-18 Months',
      ],
      sizeAvailability: {
        '0-6 Months': false,
        '6-12 Months': false,
        '12-18 Months': true,
      },
      soleMaterial: 'Synthetic Leather',
      outerMaterial: 'Faux Leather',
      closureType: 'Hook & Loop',
      waterResistanceLevel: 'Not Water Resistant',
      aboutThisItem: '''
Color: Black&Red /Size: 1-6Month/Insole Length: 11cm

Made In: China

Material: Synthetic Leather

Brand: Mix&Max

Target Gender: Girls''',
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
