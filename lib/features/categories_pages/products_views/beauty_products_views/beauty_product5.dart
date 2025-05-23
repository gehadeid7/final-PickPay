import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/products_views/product_detail_view.dart';

class BeautyProduct5 extends StatelessWidget {
  const BeautyProduct5({super.key});

  @override
  Widget build(BuildContext context) {
    final product = ProductsViewsModel(
      id: "68132a95ff7813b3d47f9da5",
      title: 'Maybelline New York Lifter Lip Gloss, 005 Petal',
      imagePaths: [
        'assets/beauty_products/makeup_5/1.png',
        'assets/beauty_products/makeup_5/2.png',
        'assets/beauty_products/makeup_5/3.png',
        'assets/beauty_products/makeup_5/4.png',
        // 'assets/beauty_products/makeup_5/5.png',
      ],
      price: 430,
      originalPrice: 510,
      rating: 4.5,
      reviewCount: 17782,
      category: 'Beauty',
      subcategory: 'Makeup',
      colorOptions: [
        'Pink',
        '004 Silk',
        '006 Reef',
        '007- Amber',
        '017 Copper',
        '019 Cold',
        'Amber',
      ],
      itemform: 'Liquid',
      skintype: 'Dry',
      brand: 'MAYBELLINE',
      finishType: 'Glossy',
      specialIngredients: 'Hyaluronic Acid',
      productbenefit: 'Glossy finish for luscious lips',
      coverage: 'Sheer to Medium',
      specialty: 'Hyaluronic Acid Infused',
      material: 'Paraben Free',
      aboutThisItem:
          '''Is this a Dangerous Good or a Hazardous Material, Substance or Waste that is regulated for transportation, storage, and/or disposal? : No

Are batteries needed to power the product or is this product a battery : No

Type : Lip Gloss

Manufacturer Number : 855456564

Brand : Maybelline New York''',
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
