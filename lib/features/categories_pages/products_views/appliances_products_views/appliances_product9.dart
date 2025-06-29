import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/products_views/product_detail_view.dart';

class AppliancesProduct9 extends StatelessWidget {
  final double rating;
  final int reviewCount;

  const AppliancesProduct9({
    super.key,
    double? rating,
    int? reviewCount,
  })  : rating = rating ?? 0.0,
        reviewCount = reviewCount ?? 0; 

  @override
  Widget build(BuildContext context) {
    final product = ProductsViewsModel(
      id: "68252918a68b49cb0616420c",
      title:
          'Panasonic Powerful Steam/Dry Iron, 1800W, NI-M300TVTD- 1 Year Warranty',
      imagePaths: [
        'assets/appliances/product9/1.png',
      ],
      price: 10499,
      originalPrice: 11000,
      rating: 4.8,
      reviewCount: 1193,
      brand: 'Panasonic',
      color: 'Violet',
      category: 'Appliances',
      subcategory: 'Small Appliances',
      material: 'Plastic and Metal',
      style: 'Modern Handheld Iron',
      itemWeight: '1.9 Kilograms',
      modelName: 'NI-M300TVTD',
      voltage: '240 Volts',
      frequency: '50 Hz',
      aboutThisItem: '''Brand : Panasonic.
Iron.
Model Number : NI-M300TVTD.
1800 W
Steam/Dry .''',
      deliveryDate: 'Sunday, 9 March',
      deliveryTimeLeft: '20hrs 36 mins',
      deliveryLocation: 'Egypt',
      inStock: true,
      shipsFrom: 'Pickpay Warehouse',
      soldBy: 'Pickpay Official',
    );

    return ProductDetailView(product: product);
  }
}
