import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/products_views/product_detail_view.dart';

class BeautyProduct16 extends StatelessWidget {
  const BeautyProduct16({super.key});

  @override
  Widget build(BuildContext context) {
    final product = ProductsViewsModel(
      id: "",
      title: 'Avon Far Away for Women, Floral Eau de Parfum 50ml',
      imagePaths: [
        'assets/beauty_products/fragrance_1/1.png',
        'assets/beauty_products/fragrance_1/2.png',
      ],
      category: 'Beauty',
      price: 534.51,
      originalPrice: 0.00,
      rating: 4.0,
      reviewCount: 19,
      brand: 'Avon',
      color: 'N/A',
      material: 'Liquid',
      dimensions: '50ml',
      style: 'Perfume',
      installationType: 'N/A',
      accessLocation: 'N/A',
      settingsCount: 0,
      powerSource: 'N/A',
      manufacturer: 'Avon',
      aboutThisItem: 'Floral Eau de Parfum with long-lasting scent for women.',
      deliveryDate: 'Monday, 17 March',
      deliveryTimeLeft: '14hrs 30 mins',
      deliveryLocation: 'Egypt',
      inStock: true,
      shipsFrom: 'Pickpay Warehouse',
      soldBy: 'Pickpay Official',
    );

    return ProductDetailView(product: product);
  }
}
