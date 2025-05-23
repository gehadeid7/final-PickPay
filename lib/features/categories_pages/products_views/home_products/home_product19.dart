import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/products_views/product_detail_view.dart';

class HomeProduct19 extends StatelessWidget {
  const HomeProduct19({super.key});

  @override
  Widget build(BuildContext context) {
    final product = ProductsViewsModel(
      id: 'home19',
      title: "Home of linen-fitted sheet set, size 120 * 200cm,off white",
      imagePaths: [
        'assets/Home_products/bath_and_bedding/bath4/1.png',
        'assets/Home_products/bath_and_bedding/bath4/2.png',
      ],
      price: 370.00,
      originalPrice: 410.00,
      rating: 3.8,
      reviewCount: 84,
      category: 'Home',
      subcategory: 'Bath & Bedding',
      brand: 'Home of Linen',
      color: 'off white',
      material: 'Cotton',
      specialfeatures:
          'Soft Texture, Fits mattresses: 120*200cm, High Quality, A bottom sheet with 4 elastic corners to hug the perimeters of the mattress, edging all around, Safe to use',
      style: 'Modern',
      size: '120*200 cm',
      numberOfPieces: '3',
      includedComponents: 'Fitted Sheet',
      pattern: 'Solid',
      threadCount: '200',
      aboutThisItem: '''Luxury Blended cotton by home of linens

Will help extend the mattress life

Improve and add comfort while sleeping

Soft to keep the sleeper lingering and comfortable to the fullest

Fits mattresses: 120*200cm''',
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
