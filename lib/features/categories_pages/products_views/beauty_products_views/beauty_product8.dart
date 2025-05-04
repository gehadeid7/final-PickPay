import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/products_views/product_detail_view.dart';

class BeautyProduct8 extends StatelessWidget {
  const BeautyProduct8({super.key});

  @override
  Widget build(BuildContext context) {
    final product = ProductsViewsModel(
      id: "",
      title:
          'Eva Aloe skin clinic anti-ageing collagen toner for firmed and refined skin - 200ml',
      imagePaths: [
        'assets/beauty_products/skincare_3/1.png',
        'assets/beauty_products/skincare_3/2.png',
      ],
      category: 'Beauty',
      price: 138.60,
      originalPrice: 210.00,
      rating: 4.0,
      reviewCount: 19,
      brand: 'Eva',
      material: 'Liquid',
      dimensions: '200ml',
      style: 'Toner',
      installationType: '',
      accessLocation: '',
      settingsCount: 0,
      powerSource: '',
      manufacturer: 'Eva Cosmetics',
      color: 'Green',
      aboutThisItem:
          'Anti-ageing collagen toner that firms and refines skin. Suitable for daily skincare routine.',
      deliveryDate: 'Sunday, 9 March',
      deliveryTimeLeft: '20hrs 36 mins',
      deliveryLocation: 'Egypt',
      inStock: true,
      shipsFrom: 'Pickpay Warehouse',
      soldBy: 'Pickpay Official',
    );

    return ProductDetailView(product: product);
  }
}
