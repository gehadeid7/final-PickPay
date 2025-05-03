import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/products_views/product_detail_view.dart';

class BeautyProduct1 extends StatelessWidget {
  const BeautyProduct1({super.key});

  @override
  Widget build(BuildContext context) {
    final product = ProductsViewsModel(
      id: "",
      title:
          'L’Oréal Paris Volume Million Lashes Panorama Mascara in Black, 9.9 ml',
      imagePaths: [
        'assets/beauty_products/makeup_1/1.png',
        'assets/beauty_products/makeup_1/2.png',
        // 'assets/beauty_products/makeup_1/3.png',
        // 'assets/beauty_products/makeup_1/4.png',
      ],
      category: 'Beauty',
      price: 401.00,
      originalPrice: 730.00,
      rating: 5.0,
      reviewCount: 88,
      brand: 'L’Oréal Paris',
      color: 'Black',
      material: 'Liquid',
      dimensions: '9.9 ml',
      style: 'Panorama Mascara',
      installationType: 'N/A',
      accessLocation: 'N/A',
      settingsCount: 0,
      powerSource: 'Manual',
      manufacturer: 'L’Oréal',
      description:
          'Achieve fanned-out lashes with L’Oréal Paris Volume Million Lashes Panorama Mascara. Its unique formula and brush offer intense volume and definition for a captivating eye look.',
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
