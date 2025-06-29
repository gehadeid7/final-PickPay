import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/products_views/product_detail_view.dart';

class AppliancesProduct8 extends StatelessWidget {
  const AppliancesProduct8({super.key});

  @override
  Widget build(BuildContext context) {
    final product = ProductsViewsModel(
      id: "68252918a68b49cb0616420b",
      title:
          'Black & Decker 1050W 2-Slice Stainless Steel Toaster, Silver/Black',
      imagePaths: [
        'assets/appliances/product8/1.png',
        'assets/appliances/product8/2.png',
        'assets/appliances/product8/3.png',
      ],
      price: 2540.00,
      rating: 3.1,
      reviewCount: 9,
      category: 'Appliances',
      subcategory: 'Small Appliances',
      brand: 'Black & Decker',
      color: 'Silver/Black',
      material: 'Stainless Steel',
      dimensions: '22D x 20W x 22H centimeters',
      style: '1050W-2 Slice toaster',
      specialfeatures: 'Electronic Browning Control',
      installationType: 'LED',
      specialty: 'Bagel, Thicker Bread Slices',
      wattage: '1050 watts',
      slotcount: '2',
      aboutThisItem: '''Six adjustable toasting levels for perfect results.

Reheat and defrost functions for versatile use.

Electronic toasting control ensures even browning.

Heat-resistant design enhances safety during use.

LED indicator for easy monitoring''',
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
