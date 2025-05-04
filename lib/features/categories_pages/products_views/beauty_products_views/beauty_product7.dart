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
      color: 'White',
      material: 'Gel Cream',
      dimensions: '50 ml',
      style: 'Dry Touch Sunscreen',
      installationType: 'N/A',
      accessLocation: 'N/A',
      settingsCount: 0,
      powerSource: 'Manual',
      manufacturer: 'La Roche-Posay',
      aboutThisItem:
          'Oil control SPF50+ sunscreen with dry touch formula, perfect for sensitive skin.',
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
