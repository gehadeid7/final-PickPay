import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/products_views/product_detail_view.dart';

class FashionProduct8 extends StatelessWidget {
  const FashionProduct8({super.key});

  @override
  Widget build(BuildContext context) {
    final product = ProductsViewsModel(
      id: '682b00c26977bd89257c0e95',
      title:
          "Sport-Q®Fury-X Latest Model Football Shoes X Football Shoes Combining Comfort Precision and Performance Excellence in Game.",
      imagePaths: [
        "assets/Fashion_products/Men_Fashion/men_fashion3/1.png",
        "assets/Fashion_products/Men_Fashion/men_fashion3/2.png",
        "assets/Fashion_products/Men_Fashion/men_fashion3/3.png",
        "assets/Fashion_products/Men_Fashion/men_fashion3/4.png",
        "assets/Fashion_products/Men_Fashion/men_fashion3/5.png",
      ],
      price: 319,
      originalPrice: 375,
      rating: 3.6,
      reviewCount: 22,
      category: 'Fashion',
      subcategory: "Men's Fashion",
      availableSizes: ['41 EU', '42 EU', '43 EU', '44 EU' '45 EU'],
      sizeAvailability: {
        '41 EU': true,
        '42 EU': false,
        '43 EU': true,
        '44 EU': true,
        '45 EU': false
      },
      style: 'Tartan',
      soleMaterial: 'Plastic',
      outerMaterial: 'Plastic',
      closureType: 'Lace-Up',
      aboutThisItem:
          '''IMPORTANT ALLERT TO SELECT YOUR SIZE CHOICE 】 To ensure the best comfort of shoes please choose the bigger size shoes of your choice of everyday shoes

UNMATCHED SPEED 】 Lightweight and flexible design allows you to move at high speed on the field, giving you excitement over your opponents.

STYLISH & STYLISH DESIGN 】High performance with appealing looks, to match your style on and off the court.

HIGH-QUALITY MATERIALS 】 Shoes are made of durable materials, ensuring long use and lasting efficacy.

OUTSIDE SOLE TAILORS 】 To ensure quality assurance, we have sewn the shoe to bring you the life of the shoe

INNOVATIVE SOLE 】 Innovative sole provides a firm grip on all types of playgrounds, reducing slippage and increasing your stability.''',
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
