import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/products_views/product_detail_view.dart';

class HomeProduct11 extends StatelessWidget {
  const HomeProduct11({super.key});

  @override
  Widget build(BuildContext context) {
    final product = ProductsViewsModel(
      id: '681dab0df9c9147444b452d7',
      title: "Neoflam Pote Cookware Set 11-Pieces, Pink Marble",
      imagePaths: [
        'assets/Home_products/kitchen/kitchen1/1.png',
        'assets/Home_products/kitchen/kitchen1/2.png',
      ],
      price: 15999.00,
      originalPrice: 17000.00,
      rating: 4.3,
      reviewCount: 43,
      category: 'home',
      subcategory: 'Kitchen & Dining',
      colorOptions: ['Pink Marble'],
      colorAvailability: {'Pink Marble': true},
      size: 'Assorted Pack',
      handleMaterial: 'Aluminum',
      material: 'Aluminum',
      brand: 'Neoflam',
      closureMaterial: 'Aluminum',
      materialTypeFree: 'Perfluorooctanoic Acid (PFOA) Free',
      compatibilityOptions: 'Induction',
      numberOfPieces: '11',
      includedComponents:
          '1 x Neoflam Pote Cookware Set 11-Pieces, Pink Marble',
      aboutThisItem:
          '''A top level, harder nonstick granite material with Ultra Non-stick performance

This cookware ensures your daily cooking is always safer and healthier

Made with a flat bottom, the cookware could be placed evenly over heat source''',
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
