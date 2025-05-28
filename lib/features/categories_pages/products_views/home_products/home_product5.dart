import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/products_views/product_detail_view.dart';

class HomeProduct5 extends StatelessWidget {
  const HomeProduct5({super.key});

  @override
  Widget build(BuildContext context) {
    final product = ProductsViewsModel(
      id: '681dab0df9c9147444b452d1',
      title: "Janssen Almany Innerspring Mattress Height 25 cm - 120 x 195 cm",
      imagePaths: [
        'assets/Home_products/furniture/furniture5/1.png',
      ],
      price: 5120.00,
      originalPrice: 5300.00,
      rating: 3.9,
      reviewCount: 58,
      category: 'home',
      subcategory: 'Furniture',
      fillMaterial: 'Cotton',
      itemWeight: '20 Kilograms',
      brand: 'Janssen',
      size: '120 x 195 cm',
      dimensions: '195L x 120W x 25Th centimeters',
      itemFirmnessDescription: 'Medium Firm',
      specialfeatures: 'Cooling',
      topStyle: 'Bonnet',
      coverMatrial: 'Cotton',
      aboutThisItem:
          'Mattress height is: 24 cmCore: Bonnell springs.Anti-rust and anti-corrosion steel.Two layers of cotton felt.Two layers of cotton.Two layers of high quality sponge.Two layers of nonwoven fabric.High quality fabric.Four handles.Four ventilation valves for cooling.',
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
