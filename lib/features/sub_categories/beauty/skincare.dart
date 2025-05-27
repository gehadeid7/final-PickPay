import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/widgets/base_category_view.dart';
import 'package:pickpay/features/categories_pages/products_views/beauty_products_views/beauty_product6.dart';
import 'package:pickpay/features/categories_pages/products_views/beauty_products_views/beauty_product7.dart';
import 'package:pickpay/features/categories_pages/products_views/beauty_products_views/beauty_product8.dart';
import 'package:pickpay/features/categories_pages/products_views/beauty_products_views/beauty_product9.dart';
import 'package:pickpay/features/categories_pages/products_views/beauty_products_views/beauty_product10.dart';

class Skincare extends StatelessWidget {
  Skincare({super.key});

  final List<ProductsViewsModel> _products = [
    ProductsViewsModel(
      id: '68132a95ff7813b3d47f9da6',
      title: 'Care & More Soft Cream With Glycerin Mixed berries 75 ML',
      price: 31.00,
      originalPrice: 44.00,
      rating: 4.0,
      reviewCount: 19,
      brand: 'Care & More',
      imagePaths: ['assets/beauty_products/skincare_1/1.png'],
    ),
    ProductsViewsModel(
      id: '68132a95ff7813b3d47f9da7',
      title:
          'La Roche-Posay Anthelios XL Non-perfumed Dry Touch oil control gel cream SPF50+ 50ml',
      price: 1168.70,
      originalPrice: 1168.70,
      rating: 4.0,
      reviewCount: 19,
      brand: 'La Roche-Posay',
      imagePaths: ['assets/beauty_products/skincare_2/1.png'],
    ),
    ProductsViewsModel(
      id: '68132a95ff7813b3d47f9da8',
      title:
          'Eva Aloe skin clinic anti-ageing collagen toner for firmed and refined skin - 200ml',
      price: 138.60,
      originalPrice: 210.00,
      rating: 4.0,
      reviewCount: 19,
      brand: 'Eva',
      imagePaths: ['assets/beauty_products/skincare_3/1.png'],
    ),
    ProductsViewsModel(
      id: '68132a95ff7813b3d47f9da9',
      title:
          'Eucerin DermoPurifyer Oil Control Skin Renewal Treatment Face Serum, 40ml',
      price: 658.93,
      originalPrice: 775.00,
      rating: 4.0,
      reviewCount: 19,
      brand: 'Eucerin',
      imagePaths: ['assets/beauty_products/skincare_4/1.png'],
    ),
    ProductsViewsModel(
      id: '68132a95ff7813b3d47f9da10',
      title: 'L\'Oréal Paris Hyaluron Expert Eye Serum - 20ml',
      price: 429.00,
      originalPrice: 0.00,
      rating: 4.8,
      reviewCount: 19,
      brand: 'L\'Oréal Paris',
      imagePaths: ['assets/beauty_products/skincare_5/1.png'],
    ),
  ];

  Widget _buildProductDetail(String productId) {
    switch (productId) {
      case '68132a95ff7813b3d47f9da6':
        return const BeautyProduct6();
      case '68132a95ff7813b3d47f9da7':
        return const BeautyProduct7();
      case '68132a95ff7813b3d47f9da8':
        return const BeautyProduct8();
      case '68132a95ff7813b3d47f9da9':
        return const BeautyProduct9();
      case '68132a95ff7813b3d47f9da10':
        return const BeautyProduct10();
      default:
        return const BeautyProduct6();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseCategoryView(
      categoryName: "Skincare",
      products: _products,
      productDetailBuilder: _buildProductDetail,
    );
  }
}
