import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/products_views/product_detail_view.dart';

class HomeProduct7 extends StatelessWidget {
  const HomeProduct7({super.key});

  @override
  Widget build(BuildContext context) {
    final product = ProductsViewsModel(
      id: '681dab0df9c9147444b452d3',
      title:
          "Luxury Bathroom Rug Shaggy Bath Mat 60 x 40 Cm, Washable Non Slip Bath Rugs for Bathroom Shower, Soft Plush Chenille Absorbent Carpets Mats, Gray (Small 60×40)",
      imagePaths: [
        'assets/Home_products/home-decor/home_decor2/1.png',
        'assets/Home_products/home-decor/home_decor2/2.png',
        'assets/Home_products/home-decor/home_decor2/3.png',
        'assets/Home_products/home-decor/home_decor2/4.png',
        'assets/Home_products/home-decor/home_decor2/5.png',
        'assets/Home_products/home-decor/home_decor2/6.png',
      ],
      price: 355.00,
      originalPrice: 440.00,
      rating: 4.1,
      reviewCount: 4,
      category: 'Home',
      subcategory: 'Home Decor',
      colorOptions: ['Grey'],
      colorAvailability: {'Grey': true},
      brand: 'Generic',
      pileheight: 'High Pile',
      itemWeight: '410 Grams',
      indoorOutdoorUsage: 'Indoor',
      isStainResistant: 'No',
      productCareInstructions: 'Machine Wash',
      aboutThisItem:
          '''Soft large size bath mat: Our 60 x 40 Cm bath mat features ultra-soft chenille fabric, which is offers exceptional comfort and support. The material’s ability to absorb water and collect dust is quite amazing, making it ideal for drying feet when stepping out of the shower, and effective at wiping off dirt and dust from shoes as a front entrance floor mat. You won’t regret investing in chenille mats for your home.

Ultra absorbent and fast dry: Not only the bathroom rug incredibly soft, but it also absorbs water from your feet very quickly. When you step out of the shower and onto this bathroom rug runner, your feet will dry in seconds. Plus, the bathroom rug runner itself dries quickly so you don't have to worry about it staying sopping wet all day.

Strong and durable backing: The more expensive strong backing which is providing the best slip resitant effect on the slippery bathroom. As durable bathroom runner caring for your family, the bathroom runner is more suitable for kids and the elderly. Please place rug on clean dry smooth floor.

Machine washable: Our grey bathroom mat can be machine washed again and again, the tpr backing ensures its durability and longevity. Tips: It's probably best to tumble dry on low or hang dry it to avoid any shrinking. We recommend washing your bathroom rug every two weeks to keep it clean.

Multi-purpose use: The large bath rug mat measure 60 by 40 Cm, this size is perfect for a nice open bathroom, outside the tub, front of the sink, kitchen, entrance or where you want. From a decoration viewpoint, the chenille bath rug mat is easy to match your bathroom towels and other accessories.''',
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
