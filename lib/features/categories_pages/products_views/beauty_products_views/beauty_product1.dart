import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/products_views/product_detail_view.dart';

class BeautyProduct1 extends StatelessWidget {
  const BeautyProduct1({super.key});

  @override
  Widget build(BuildContext context) {
    final product = ProductsViewsModel(
      id: "682b00d16977bd89257c0e9d",
      title:
          'L’Oréal Paris Volume Million Lashes Panorama Mascara in Black, 9.9 ml',
      imagePaths: [
        'assets/beauty_products/makeup_1/1.png',
        'assets/beauty_products/makeup_1/2.png',
        // 'assets/beauty_products/makeup_1/3.png',
        // 'assets/beauty_products/makeup_1/4.png',
      ],
      price: 443,
      originalPrice: 730.00,
      rating: 4.2,
      reviewCount: 4470,
      category: 'Beauty',
      subcategory: 'Makeup',
      productbenefit:
          'Provides intense volume and long-lasting, clump-free definition while being suitable for sensitive eyes',
      brand: 'L’Oréal Paris',
      color: 'Black',
      specialfeatures: 'Clump-free',
      material: 'Paraben Free, Silicone Free, Aluminum Free, Sulfate Free',
      itemform: 'Gel',
      specialty: 'Long Lasting',
      numberofitems: '1',
      unitcount: '1 count',
      itemvolume: '9.9 Milliliters',
      aboutThisItem:
          '''Provides lashes that look fuller and eyes that look 1.4x bigger

5% stretchflex complex, allowing seamless stretches while extending each lash up and out with maximum panoramic volume.

Suitable for sensitive eyes

No-clump Mascara

A brush with short & long bristles to volumize & fan the eyelashes''',
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
