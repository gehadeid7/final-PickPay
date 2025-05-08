import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/products_views/product_detail_view.dart';

class BeautyProduct14 extends StatelessWidget {
  const BeautyProduct14({super.key});

  @override
  Widget build(BuildContext context) {
    final product = ProductsViewsModel(
      id: "",
      title:
          "L'Oreal Professionnel Absolut Repair 10-In-1 Hair Serum Oil - 90ml",
      imagePaths: [
        'assets/beauty_products/haircare_4/1.png',
        'assets/beauty_products/haircare_4/2.png',
        'assets/beauty_products/haircare_4/3.png',
      ],
      price: 965.00,
      originalPrice: 1214.00,
      rating: 4.6,
      reviewCount: 11987,
      brand: "L'Oreal Professionnel",
      itemvolume: '90 Milliliters',
      itemform: 'Cream',
      liquidVolume: '90 Milliliters',
      productbenefit: 'Frizz Control',
      materialfeature: 'Paraben Free',
      recommendedUsesForProduct: 'Hair Treatment',
      numberofitems: '1',
      aboutThisItem:
          '''The professional formula of the 10 in 1 Perfecting Multipurpose Spray instantly provides damaged hair with 10 benefits

Treatment: Nourishment, resurfacing, split ends reduction, lightweight touch & softness. 

Manageability: Detangling, easy-blowdry, frizz control. 

Protection: anti pollution and heat protection up to 230°C/450°F The spray allows an easy and homogeneous distribution of the lightweight milky formula.''',
      deliveryDate: 'Friday, 14 March',
      deliveryTimeLeft: '17hrs 40 mins',
      deliveryLocation: 'Egypt',
      inStock: true,
      shipsFrom: 'Pickpay',
      soldBy: 'Pickpay',
    );

    return ProductDetailView(product: product);
  }
}
