import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/products_views/product_detail_view.dart';

class BeautyProduct9 extends StatelessWidget {
  const BeautyProduct9({super.key});

  @override
  Widget build(BuildContext context) {
    final product = ProductsViewsModel(
      id: "68132a95ff7813b3d47f9da9",
      title:
          'Eucerin DermoPurifyer Oil Control Skin Renewal Treatment Face Serum, 40ml',
      imagePaths: [
        'assets/beauty_products/skincare_4/1.png',
        // 'assets/beauty_products/skincare_4/2.png',
        'assets/beauty_products/skincare_4/3.png',
      ],
      price: 533.93,
      originalPrice: 775.00,
      rating: 4.3,
      reviewCount: 121,
      brand: 'Eucerin',
      itemvolume: '40 Milliliters',
      itemform: 'serum',
      numberofitems: '1',
      scent: 'Unscented',
      activeIngredients: 'glycolic acid, vitamin e',
      skintype: 'Blemish-prone skin',
      specialfeatures: 'Without Smell',
      ageRangeDescription: 'Adult',
      aboutThisItem:
          '''Eucerin DermoPurifyer Oil Control Skin Renewal Treatment Face Serum for Blemish and Acne-Prone Skin with Hydroxy Complex, Unclogs Pores, Reduces Blemishes, Supports Skin Renewal, 40ml

Exfoliating blemish serum for clearer, more even skin .

Formulated with 10% Hydroxy Acids

Supports skin renewal

Starts to visibly improve skin after just 1 week''',
      deliveryDate: 'Sunday, 9 March',
      deliveryTimeLeft: '20hrs 36 mins',
      deliveryLocation: 'Egypt',
      inStock: true,
      shipsFrom: 'Pickpay',
      soldBy: 'Pickpay ',
      color: 'White',
    );

    return ProductDetailView(product: product);
  }
}
