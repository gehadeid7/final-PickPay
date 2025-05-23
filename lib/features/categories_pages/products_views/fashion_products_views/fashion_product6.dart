import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/products_views/product_detail_view.dart';

class FashionProduct6 extends StatelessWidget {
  const FashionProduct6({super.key});

  @override
  Widget build(BuildContext context) {
    final product = ProductsViewsModel(
      id: '68132a95ff7813b3d47f9da6',
      title:
          "DeFacto Man Modern Fit Polo Neck Short Sleeve B6374AX Polo T-Shirt",
      imagePaths: [
        "assets/Fashion_products/Men_Fashion/men_fashion1/1.png",
        "assets/Fashion_products/Men_Fashion/men_fashion1/2.png",
        "assets/Fashion_products/Men_Fashion/men_fashion1/3.png",
        "assets/Fashion_products/Men_Fashion/men_fashion1/4.png",
      ],
      availableSizes: [
        'XSmall',
        'Small',
        'Medium',
        'Large',
        'XLarge',
        'XXLarge'
      ],
      colorOptions: [
        'Navy',
        'Antracite',
        'Grey',
        'Blue',
      ],
      colorAvailability: {
        'Navy': true,
        'Antracite': true,
        'Grey': false,
        'Blue': true,
      },
      careInstruction: 'Machine washable',
      aboutThisItem: '''B6374AX
Polyester 100%
Modern Fit
Polo Neck
Short Sleeve
''',
      price: 599,
      originalPrice: 640,
      rating: 5.0,
      reviewCount: 438,
      category: 'Fashion',
      subcategory: "Men's Fashion",
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
