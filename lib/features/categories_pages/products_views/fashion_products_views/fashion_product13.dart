import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/products_views/product_detail_view.dart';

class FashionProduct13 extends StatelessWidget {
  const FashionProduct13({super.key});

  @override
  Widget build(BuildContext context) {
    final product = ProductsViewsModel(
      id: '68132a95ff7813b3d47f9da13',
      title: 'DeFacto Girls Cropped Fit Long Sleeve B9857A8 Denim Jacket',
      imagePaths: [
        "assets/Fashion_products/Kids_Fashion/kids_fashion3/1.png",
        "assets/Fashion_products/Kids_Fashion/kids_fashion3/1.png",
        "assets/Fashion_products/Kids_Fashion/kids_fashion3/3.png",
        "assets/Fashion_products/Kids_Fashion/kids_fashion3/4.png",
        "assets/Fashion_products/Kids_Fashion/kids_fashion3/5.png",
      ],
      price: 899,
      originalPrice: 950,
      rating: 5.0,
      reviewCount: 885,
      colorOptions: ['ice Blue (NM63)'],
      colorAvailability: {
        'ice Blue (NM63)': true,
      },
      availableSizes: [
        '5-6 Years',
        '6-7 Years',
        '7-8 Years',
        '8-9 Years',
      ],
      sizeAvailability: {
        '5-6 Years': true,
        '6-7 Years': true,
        '7-8 Years': true,
        '8-9 Years': true,
      },
      careInstruction: 'Machine Wash',
      closureType: 'Button',
      lining: 'Cotton',
      aboutThisItem: '''B9857A8
Cotton 100%
Cropped Fit
Long Sleeve''',
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
