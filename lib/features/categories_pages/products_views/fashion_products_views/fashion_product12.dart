import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/products_views/product_detail_view.dart';

class FashionProduct12 extends StatelessWidget {
  const FashionProduct12({super.key});

  @override
  Widget build(BuildContext context) {
    final product = ProductsViewsModel(
      id: '68132a95ff7813b3d47f9da12',
      title: "Kidzo Boys Pajamas",
      imagePaths: [
        "assets/Fashion_products/Kids_Fashion/kids_fashion2/1.png",
        "assets/Fashion_products/Kids_Fashion/kids_fashion2/2.png",
      ],
      price: 580,
      originalPrice: 621,
      rating: 5.0,
      reviewCount: 3,
      colorOptions: [
        'white',
        'Beige',
        'Gray',
        'Mint Green',
      ],
      colorAvailability: {
        'white': true,
        'Beige': true,
        'Gray': true,
        'Mint Green': true,
      },
      availableSizes: [
        '2-3 Years',
        '3-4 Years',
        '4-5 Years',
        '5-6 Years',
        '6-7 Years',
      ],
      sizeAvailability: {
        '2-3 Years': true,
        '3-4 Years': true,
        '4-5 Years': true,
        '5-6 Years': false,
        '6-7 Years': true,
      },
      careInstruction: 'Machine wash',
      closureType: 'Pull On',
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
