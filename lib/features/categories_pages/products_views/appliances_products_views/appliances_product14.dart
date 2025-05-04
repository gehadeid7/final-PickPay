import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/products_views/product_detail_view.dart';

class AppliancesProduct14 extends StatelessWidget {
  const AppliancesProduct14({super.key});

  @override
  Widget build(BuildContext context) {
    final product = ProductsViewsModel(
      id: "68132a95ff7813b3d47f9db2",
      title:
          'Black & Decker 1.7L Concealed Coil Stainless Steel Kettle, Jc450-B5, Silver',
      imagePaths: [
        'assets/appliances/product14/1.png',
        'assets/appliances/product14/2.png',
        'assets/appliances/product14/3.png',
        'assets/appliances/product14/4.png',
        'assets/appliances/product14/5.png',
        'assets/appliances/product14/6.png',
      ],
      category: 'Appliances',
      price: 1594,
      originalPrice: 1730,
      rating: 4.5,
      reviewCount: 1162,
      brand: 'Black & Decker',
      color: 'Silver',
      material: 'Stainless Steel',
      dimensions: '1.7L',
      style: 'Electric Kettle',
      installationType: 'Corded Base',
      accessLocation: 'Top',
      settingsCount: 1,
      powerSource: 'Electric',
      manufacturer: 'Black & Decker',
      aboutThisItem:
          'Stainless steel 1.7L kettle with concealed coil and auto shut-off for safe, fast boiling.',
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
