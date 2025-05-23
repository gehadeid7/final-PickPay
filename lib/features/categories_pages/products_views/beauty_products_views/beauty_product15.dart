import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/products_views/product_detail_view.dart';

class BeautyProduct15 extends StatelessWidget {
  const BeautyProduct15({super.key});

  @override
  Widget build(BuildContext context) {
    final product = ProductsViewsModel(
      id: "68132a95ff7813b3d47f9da15",
      title:
          'CORATED Heatless Curling Rod Headband Kit with Clips and Scrunchie',
      imagePaths: [
        'assets/beauty_products/haircare_5/1.png',
        // 'assets/beauty_products/haircare_5/2.png',
        // 'assets/beauty_products/haircare_5/3.png',
        'assets/beauty_products/haircare_5/4.png',
      ],
      price: 93,
      originalPrice: 111,
      rating: 4.0,
      reviewCount: 19,
      brand: 'CORATED',
      color: 'Pink',
      category: 'Beauty',
      subcategory: 'Haircare',
      material: 'Silk',
      itemform: 'Flexi Rod+clip',
      manufacturer: 'Flumine-US',
      resultingHairType: 'Curly',
      hairtype: 'All',
      unitcount: '1 Count',
      numberofitems: '4',
      aboutThisItem:
          '''【Upgrade Heatless Curls】Upgraded curling rod headband is made of satin material outside and soft material inside, which is much softer, and more comfortable to sleep in than the old version, help you to stay in place, hold your hair tightly and no chemical smell.

【No Heat Curlers】Wet dry hair with a spray bottle or wet comb before using a heatless curling iron. Hair curlers for long hair or medium hair length.

【No Damage Silk Curlers】Hair rollers that are long enough can be tightly fixed and are perfect for thick, thin, curly, or straight hair. The rounded edges and smooth surface will not pull or damage your hair.

【Easy to Use】While your hair is slightly damp, put the curling rod over your head like a headband, you can clip it at the top or secure one side with a scrunchie like a ponytail, and then wind dry hair around the other side of the curling ribbon and secure with a scrunchie on the bottom. Make sure to wind tightly and start near the top of your head. Can leave in for more than two hours in the daytime or overnight with dry hair.

【Attention】Sleep curlers are not suitable for girls with short hair and thinning hair. The length of the heatless curls is 39.3 inches, suitable for medium hair and long hair. Make sure it's suitable for your hair before you place an order. Any problem with the curlers, please contact us directly.''',
      deliveryDate: 'Saturday, 15 March',
      deliveryTimeLeft: '16hrs 10 mins',
      deliveryLocation: 'Egypt',
      inStock: true,
      shipsFrom: 'Pickpay',
      soldBy: 'Pickpay',
    );

    return ProductDetailView(product: product);
  }
}
