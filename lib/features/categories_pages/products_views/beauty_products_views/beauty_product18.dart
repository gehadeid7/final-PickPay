import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/products_views/product_detail_view.dart';

class BeautyProduct18 extends StatelessWidget {
  const BeautyProduct18({super.key});

  @override
  Widget build(BuildContext context) {
    final product = ProductsViewsModel(
      id: "",
      title:
          'Bath Body Gingham Gorgeous Fine Fragrance Mist, Size/Volume: 8 fl oz / 236 mL',
      imagePaths: [
        'assets/beauty_products/fragrance_3/1.png',
        'assets/beauty_products/fragrance_3/2.png',
        'assets/beauty_products/fragrance_3/3.png',
      ],
      category: 'Beauty',
      price: 1350.00,
      originalPrice: 1350.00,
      rating: 4.0,
      reviewCount: 19,
      brand: 'Bath & Body Works',
      color: 'N/A',
      material: 'Mist',
      dimensions: '236ml',
      style: 'Fragrance Mist',
      installationType: 'N/A',
      accessLocation: 'N/A',
      settingsCount: 0,
      powerSource: 'N/A',
      manufacturer: 'Bath & Body Works',
      aboutThisItem:
          'Gingham Gorgeous body mist with a delightful floral scent in a large 236ml size.',
      deliveryDate: 'Wednesday, 19 March',
      deliveryTimeLeft: '13hrs 10 mins',
      deliveryLocation: 'Egypt',
      inStock: true,
      shipsFrom: 'Pickpay Warehouse',
      soldBy: 'Pickpay Official',
    );

    return ProductDetailView(product: product);
  }
}
