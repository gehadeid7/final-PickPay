import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/products_views/product_detail_view.dart';

class BeautyProduct17 extends StatelessWidget {
  const BeautyProduct17({super.key});

  @override
  Widget build(BuildContext context) {
    final product = ProductsViewsModel(
      id: "",
      title:
          'Memwa Coco Memwa Long Lasting Perfume Fragrance Luxury Eau De Parfum EDP Perfume for Women',
      imagePaths: [
        'assets/beauty_products/fragrance_2/1.png',
        'assets/beauty_products/fragrance_2/2.png',
      ],
      category: 'Beauty',
      price: 624.04,
      originalPrice: 624.04,
      rating: 4.0,
      reviewCount: 19,
      brand: 'Memwa',
      color: 'N/A',
      material: 'Liquid',
      dimensions: 'Standard Bottle',
      style: 'Luxury Perfume',
      installationType: 'N/A',
      accessLocation: 'N/A',
      settingsCount: 0,
      powerSource: 'N/A',
      manufacturer: 'Memwa',
      description:
          'Long-lasting luxury fragrance for women with elegant scent profile.',
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
