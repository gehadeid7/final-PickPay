import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/products_views/product_detail_view.dart';

class BeautyProduct20 extends StatelessWidget {
  const BeautyProduct20({super.key});

  @override
  Widget build(BuildContext context) {
    final product = ProductsViewsModel(
      id: "",
      title: 'Jacques Bogart One Man Show for Men, Eau de Toilette - 100ml',
      imagePaths: [
        'assets/beauty_products/fragrance_5/1.png',
        'assets/beauty_products/fragrance_5/2.png',
        'assets/beauty_products/fragrance_5/3.png',
        'assets/beauty_products/fragrance_5/4.png',
      ],
      category: 'Beauty',
      price: 600,
      originalPrice: 699,
      rating: 4.0,
      reviewCount: 19,
      brand: 'Jacques Bogart',
      modelName: 'One Man Show',
      itemform: 'Liquid',
      scent: 'Wood',
      itemvolume: '100 Milliliters',
      material: 'fragrance',
      materialfeature: 'Natural',
      fragranceConcentration: 'Eau de Toilette',
      specialfeatures: 'Travel Size',
      aboutThisItem:
          '''Middle Notes Are : Labdanum, Nutmeg, Spices, Carnation, Patchouli, Jasmine, Vetiver,Rose, Pine tree needles and Geranium.

Base Notes Are : Leather, Sandalwood, Tonka Bean, Amber, Coconut, Vanilla, Oakmoss, Cedar, Styrax and Castoreum.

Brand Name : Jacques Bogart''',
      deliveryDate: 'Friday, 21 March',
      deliveryTimeLeft: '12hrs 10 mins',
      deliveryLocation: 'Egypt',
      inStock: true,
      shipsFrom: 'Pickpay',
      soldBy: 'Pickpay',
    );

    return ProductDetailView(product: product);
  }
}
