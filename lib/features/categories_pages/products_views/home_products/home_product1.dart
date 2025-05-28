import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/products_views/product_detail_view.dart';

class HomeProduct1 extends StatelessWidget {
  const HomeProduct1({super.key});

  @override
  Widget build(BuildContext context) {
    final product = ProductsViewsModel(
      id: '681dab0df9c9147444b452cd',
      title: "Golden Life Sofa Bed - Size 190 cm - Beige",
      imagePaths: [
        'assets/Home_products/furniture/furniture1/1.png',
        'assets/Home_products/furniture/furniture1/2.png',
        'assets/Home_products/furniture/furniture1/3.png',
      ],
      price: 7850.00,
      originalPrice: 7999.00,
      rating: 2.4,
      reviewCount: 3,
      colorOptions: ['Beige'],
      colorAvailability: {
        'Beige': true,
      },
      category: 'home',
      subcategory: 'Furniture',
      requiredAssembly: 'No',
      brand: 'Generic',
      dimensions: '70D x 190W x 90H centimeters',
      style: 'Modern',
      seatingCapacity: '3',
      sofaType: 'Sofa Bed',
      upholsteryFabricType: 'Linen',
      itemShape: 'Rectangular',
      armStyle: 'Armless',
      aboutThisItem: '''Arm Style: Armless
Style: Modern''',
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
