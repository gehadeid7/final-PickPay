import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/products_views/product_detail_view.dart';

class BeautyProduct17 extends StatelessWidget {
  const BeautyProduct17({super.key});

  @override
  Widget build(BuildContext context) {
    final product = ProductsViewsModel(
      id: "682b00d16977bd89257c0ead",
      title:
          'Memwa Coco Memwa Long Lasting Perfume Fragrance Luxury Eau De Parfum EDP Perfume for Women',
      imagePaths: [
        'assets/beauty_products/fragrance_2/1.png',
        'assets/beauty_products/fragrance_2/2.png',
      ],
      price: 608.00,
      rating: 3.4,
      reviewCount: 2,
      modelName: 'Memwa Coco Memwa',
      itemform: 'Liquid',
      category: 'Beauty',
      subcategory: 'Fragrance',
      scent: 'Amber',
      brand: 'Gulf Orchid',
      itemvolume: '110 Milliliters',
      materialfeature: 'Cruelty Free',
      material: 'Preservative Free, Paraben Free',
      fragranceConcentration: 'Eau de Parfum',
      specialfeatures: 'Long Lasting',
      aboutThisItem: '''Family: Oriental Floral

Top Notes: Citrus, Fresh, Fruity

Heart Notes: Freesia, Jasmine, Lily of The Valley

Base Notes: Moss, Musk, Patchouli''',
      deliveryDate: 'Tuesday, 18 March',
      deliveryTimeLeft: '13hrs 50 mins',
      deliveryLocation: 'Egypt',
      inStock: true,
      shipsFrom: 'Pickpay Warehouse',
      soldBy: 'Pickpay Official',
    );

    return ProductDetailView(product: product);
  }
}
