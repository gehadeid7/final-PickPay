import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/products_views/product_detail_view.dart';

class BeautyProduct3 extends StatelessWidget {
  const BeautyProduct3({super.key});

  @override
  Widget build(BuildContext context) {
    final product = ProductsViewsModel(
      id: "682b00d16977bd89257c0e9f",
      title: 'Cybele Smooth N`Wear Powder Blush Corail 17 - 3.7gm',
      imagePaths: [
        'assets/beauty_products/makeup_3/1.png',
      ],
      price: 189,
      originalPrice: 240,
      rating: 5.0,
      reviewCount: 88,
      category: 'Beauty',
      subcategory: 'Makeup',
      itemform: 'Powder',
      filtertype: 'Natural',
      brand: 'Cybele',
      coverage: 'Medium',
      skintype: 'All',
      productbenefit: 'Color Correction',
      unitcount: '3.7 gram',
      numberofitems: '1',
      style: 'Modern',
      aboutThisItem:
          'Various shades that fit all skin tones with exceptional perfect color.',
      deliveryDate: 'Sunday, 9 March',
      deliveryTimeLeft: '20hrs 36 mins',
      deliveryLocation: 'Egypt',
      inStock: true,
      shipsFrom: 'Pickpay ',
      soldBy: 'Pickpay ',
    );

    return ProductDetailView(product: product);
  }
}
