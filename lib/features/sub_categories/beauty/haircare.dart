import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/widgets/base_category_view.dart';
import 'package:pickpay/features/categories_pages/products_views/beauty_products_views/beauty_product1.dart';
import 'package:pickpay/features/categories_pages/products_views/beauty_products_views/beauty_product11.dart';
import 'package:pickpay/features/categories_pages/products_views/beauty_products_views/beauty_product12.dart';
import 'package:pickpay/features/categories_pages/products_views/beauty_products_views/beauty_product13.dart';
import 'package:pickpay/features/categories_pages/products_views/beauty_products_views/beauty_product14.dart';
import 'package:pickpay/features/categories_pages/products_views/beauty_products_views/beauty_product15.dart';

class Haircare extends StatelessWidget {
  Haircare({super.key});

  final List<ProductsViewsModel> _products = [
    ProductsViewsModel(
      id: '68132a95ff7813b3d47f9da11',
      title: 'L\'Oréal Paris Elvive Hyaluron Pure Shampoo 400ML',
      price: 142.20,
      originalPrice: 0.00,
      rating: 4.0,
      reviewCount: 19,
      brand: 'L\'Oréal Paris',
      imagePaths: ['assets/beauty_products/haircare_1/1.png'],
    ),
    ProductsViewsModel(
      id: '68132a95ff7813b3d47f9da12',
      title: 'Raw African Booster Shea Set',
      price: 650.00,
      originalPrice: 0.00,
      rating: 4.0,
      reviewCount: 19,
      brand: 'Raw African',
      imagePaths: ['assets/beauty_products/haircare_2/1.png'],
    ),
    ProductsViewsModel(
      id: '68132a95ff7813b3d47f9da13',
      title:
          'Garnier Color Naturals Permanent Crème Hair Color - 8.1 Light Ash Blonde',
      price: 132.00,
      originalPrice: 0.00,
      rating: 4.0,
      reviewCount: 19,
      brand: 'Garnier',
      imagePaths: ['assets/beauty_products/haircare_3/1.png'],
    ),
    ProductsViewsModel(
      id: '68132a95ff7813b3d47f9da14',
      title:
          'L\'Oreal Professionnel Absolut Repair 10-In-1 Hair Serum Oil - 90ml',
      price: 965.00,
      originalPrice: 1214.00,
      rating: 4.0,
      reviewCount: 19,
      brand: 'L\'Oreal Professionnel',
      imagePaths: ['assets/beauty_products/haircare_4/1.png'],
    ),
    ProductsViewsModel(
      id: '68132a95ff7813b3d47f9da15',
      title:
          'CORATED Heatless Curling Rod Headband Kit with Clips and Scrunchie',
      price: 94.96,
      originalPrice: 111.98,
      rating: 4.0,
      reviewCount: 19,
      brand: 'CORATED',
      imagePaths: ['assets/beauty_products/haircare_5/1.png'],
    ),
  ];

  Widget _buildProductDetail(String productId) {
    try {
      switch (productId) {
        case '68132a95ff7813b3d47f9da11':
          return const BeautyProduct11();
        case '68132a95ff7813b3d47f9da12':
          return const BeautyProduct12();
        case '68132a95ff7813b3d47f9da13':
          return const BeautyProduct13();
        case '68132a95ff7813b3d47f9da14':
          return const BeautyProduct14();
        case '68132a95ff7813b3d47f9da15':
          return const BeautyProduct15();
        default:
          return const BeautyProduct1(); // Default fallback
      }
    } catch (e) {
      debugPrint('Error building product detail for $productId: $e');
      return const Scaffold(
        body: Center(
          child: Text('Error loading product details'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseCategoryView(
      categoryName: 'Haircare',
      products: _products,
      productDetailBuilder: _buildProductDetail,
    );
  }
}
