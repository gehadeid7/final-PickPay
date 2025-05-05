import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/products_views/product_detail_view.dart';

class BeautyProduct7 extends StatelessWidget {
  const BeautyProduct7({super.key});

  @override
  Widget build(BuildContext context) {
    final product = ProductsViewsModel(
      id: "",
      title:
          'La Roche-Posay Anthelios XL Non-perfumed Dry Touch oil control gel cream SPF50+ 50ml',
      imagePaths: [
        'assets/beauty_products/skincare_2/1.png',
        'assets/beauty_products/skincare_2/2.png',
        'assets/beauty_products/skincare_2/3.png',
        'assets/beauty_products/skincare_2/4.png',
      ],
      category: 'Beauty',
      price: 1168.70,
      originalPrice: 1168.70,
      rating: 4.0,
      reviewCount: 19,
      brand: 'La Roche-Posay',
      itemvolume: '50 Milliliters',
      unitcount: '50.0 millilitre',
      itemWeight: '50 Grams',
      sunProtectionFactor: '50 Sun Protection Factor (SPF)',
      activeIngredients: 'Avobenzone',
      skintype: 'Oily, Combination',
      numberofitems: '1',
      productbenefit: 'Soothing, Antioxidant',
      aboutThisItem:
          '''Dry touch texture : double anti-shine action, immediate absorption, ultra-dry finish, no white marks.

Ideal for combination to oily skin.

Prevents sun intolerance, commonly known as sun allergies.

Also prevents sun-induced pigment spots (pregnancy, photosensitization...).''',
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
