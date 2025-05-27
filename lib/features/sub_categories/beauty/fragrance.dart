import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/widgets/base_category_view.dart';
import 'package:pickpay/features/categories_pages/products_views/beauty_products_views/beauty_product1.dart';
import 'package:pickpay/features/categories_pages/products_views/beauty_products_views/beauty_product16.dart';
import 'package:pickpay/features/categories_pages/products_views/beauty_products_views/beauty_product17.dart';
import 'package:pickpay/features/categories_pages/products_views/beauty_products_views/beauty_product18.dart';
import 'package:pickpay/features/categories_pages/products_views/beauty_products_views/beauty_product19.dart';
import 'package:pickpay/features/categories_pages/products_views/beauty_products_views/beauty_product20.dart';

class Fragrance extends StatelessWidget {
  Fragrance({super.key});

  final List<ProductsViewsModel> _products = [
    ProductsViewsModel(
      id: '68132a95ff7813b3d47f9da16',
      title: 'Avon Far Away for Women, Floral Eau de Parfum 50ml',
      price: 534.51,
      originalPrice: 0.00,
      rating: 4.0,
      reviewCount: 19,
      brand: 'Avon',
      imagePaths: ['assets/beauty_products/fragrance_1/1.png'],
    ),
    ProductsViewsModel(
      id: '68132a95ff7813b3d47f9da17',
      title:
          'Memwa Coco Memwa Long Lasting Perfume Fragrance Luxury Eau De Parfum EDP Perfume for Women',
      price: 624.04,
      originalPrice: 624.04,
      rating: 4.0,
      reviewCount: 19,
      brand: 'Memwa',
      imagePaths: ['assets/beauty_products/fragrance_2/1.png'],
    ),
    ProductsViewsModel(
      id: '68132a95ff7813b3d47f9da18',
      title:
          'Bath Body Gingham Gorgeous Fine Fragrance Mist, Size/Volume: 8 fl oz / 236 mL',
      price: 1350.00,
      originalPrice: 1350.00,
      rating: 4.0,
      reviewCount: 19,
      brand: 'Bath Body',
      imagePaths: ['assets/beauty_products/fragrance_3/1.png'],
    ),
    ProductsViewsModel(
      id: '68132a95ff7813b3d47f9da19',
      title:
          'NIVEA Antiperspirant Spray for Women, Pearl & Beauty Pearl Extracts, 150ml',
      price: 123.00,
      originalPrice: 123.00,
      rating: 4.0,
      reviewCount: 19,
      brand: 'NIVEA',
      imagePaths: ['assets/beauty_products/fragrance_4/1.png'],
    ),
    ProductsViewsModel(
      id: '68132a95ff7813b3d47f9da20',
      title: 'Jacques Bogart One Man Show for Men, Eau de Toilette - 100ml',
      price: 840.00,
      originalPrice: 900.00,
      rating: 4.0,
      reviewCount: 19,
      brand: 'Jacques Bogart',
      imagePaths: ['assets/beauty_products/fragrance_5/1.png'],
    ),
  ];

  Widget _buildProductDetail(String productId) {
    try {
      switch (productId) {
        case '68132a95ff7813b3d47f9da16':
          return const BeautyProduct16();
        case '68132a95ff7813b3d47f9da17':
          return const BeautyProduct17();
        case '68132a95ff7813b3d47f9da18':
          return const BeautyProduct18();
        case '68132a95ff7813b3d47f9da19':
          return const BeautyProduct19();
        case '68132a95ff7813b3d47f9da20':
          return const BeautyProduct20();
        default:
          return const BeautyProduct1(); // Default fallback
      }
    } catch (e) {
      debugPrint('Error building product detail for $productId: $e');
      return Scaffold(
        appBar: AppBar(title: const Text('Error')),
        body: const Center(
          child: Text('Error loading product details'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseCategoryView(
      categoryName: 'Fragrance',
      products: _products,
      productDetailBuilder: _buildProductDetail,
    );
  }
}
