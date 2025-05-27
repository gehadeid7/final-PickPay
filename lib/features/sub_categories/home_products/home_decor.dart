import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/widgets/base_category_view.dart';
import 'package:pickpay/features/categories_pages/products_views/home_products/home_product1.dart';
import 'package:pickpay/features/categories_pages/products_views/home_products/home_product6.dart';
import 'package:pickpay/features/categories_pages/products_views/home_products/home_product7.dart';
import 'package:pickpay/features/categories_pages/products_views/home_products/home_product8.dart';
import 'package:pickpay/features/categories_pages/products_views/home_products/home_product9.dart';
import 'package:pickpay/features/categories_pages/products_views/home_products/home_product10.dart';

class HomeDecorview extends StatelessWidget {
  HomeDecorview({super.key});

  final List<ProductsViewsModel> _products = [
    ProductsViewsModel(
      id: 'home6',
      title: 'Golden Lighting LED Gold Lampshade + 1 Crystal Cylinder Bulb.',
      price: 1128.00,
      originalPrice: 0.0,
      rating: 4.0,
      reviewCount: 19,
      brand: 'Golden Lighting',
      imagePaths: ['assets/Home_products/home-decor/home_decor1/1.png'],
    ),
    ProductsViewsModel(
      id: 'home7',
      title:
          'Luxury Bathroom Rug Shaggy Bath Mat 60x40 Cm, Washable Non Slip, Soft Chenille, Gray',
      price: 355.00,
      originalPrice: 0.0,
      rating: 4.0,
      reviewCount: 19,
      brand: 'Luxury',
      imagePaths: ['assets/Home_products/home-decor/home_decor2/1.png'],
    ),
    ProductsViewsModel(
      id: 'home8',
      title: 'Glass Vase 15cm',
      price: 250.00,
      originalPrice: 0.0,
      rating: 4.0,
      reviewCount: 19,
      brand: 'Generic',
      imagePaths: ['assets/Home_products/home-decor/home_decor3/1.png'],
    ),
    ProductsViewsModel(
      id: 'home9',
      title:
          'Amotpo Indoor/Outdoor Wall Clock, 12-Inch Waterproof with Thermometer & Hygrometer',
      price: 549.00,
      originalPrice: 0.0,
      rating: 4.0,
      reviewCount: 19,
      brand: 'Amotpo',
      imagePaths: ['assets/Home_products/home-decor/home_decor4/1.png'],
    ),
    ProductsViewsModel(
      id: 'home10',
      title:
          'Oliruim Black Home Decor Accent Art Woman Face Statue - 2 Pieces Set',
      price: 650.00,
      originalPrice: 0.0,
      rating: 5.0,
      reviewCount: 19,
      brand: 'Oliruim',
      imagePaths: ['assets/Home_products/home-decor/home_decor5/1.png'],
    ),
  ];

  Widget _buildProductDetail(String productId) {
    switch (productId) {
      case 'home6':
        return const HomeProduct6();
      case 'home7':
        return const HomeProduct7();
      case 'home8':
        return const HomeProduct8();
      case 'home9':
        return const HomeProduct9();
      case 'home10':
        return const HomeProduct10();
      default:
        return const HomeProduct1();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseCategoryView(
      categoryName: 'Home Decor',
      products: _products,
      productDetailBuilder: _buildProductDetail,
    );
  }
}
