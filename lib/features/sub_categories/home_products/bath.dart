import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/widgets/base_category_view.dart';
import 'package:pickpay/features/categories_pages/products_views/home_products/home_product1.dart';
import 'package:pickpay/features/categories_pages/products_views/home_products/home_product16.dart';
import 'package:pickpay/features/categories_pages/products_views/home_products/home_product17.dart';
import 'package:pickpay/features/categories_pages/products_views/home_products/home_product18.dart';
import 'package:pickpay/features/categories_pages/products_views/home_products/home_product19.dart';
import 'package:pickpay/features/categories_pages/products_views/home_products/home_product20.dart';

class BathView extends StatelessWidget {
  BathView({super.key});

  final List<ProductsViewsModel> _products = [
    ProductsViewsModel(
      id: 'home16',
      title: 'Banotex Cotton Towel 50x100 (Sugar)',
      price: 170.00,
      originalPrice: 200.99,
      rating: 4.6,
      reviewCount: 4576,
      brand: 'Banotex',
      imagePaths: ['assets/Home_products/bath_and_bedding/bath1/1.png'],
    ),
    ProductsViewsModel(
      id: 'home17',
      title: 'Fiber pillow 2 pieces size 40x60',
      price: 180.00,
      originalPrice: 200.99,
      rating: 4.6,
      reviewCount: 4576,
      brand: 'Generic',
      imagePaths: ['assets/Home_products/bath_and_bedding/bath2/1.png'],
    ),
    ProductsViewsModel(
      id: 'home18',
      title:
          'Bedsure 100% Cotton Blankets Queen Size for Bed - Waffle Weave Blankets for Summer',
      price: 604.00,
      originalPrice: 700.99,
      rating: 4.6,
      reviewCount: 4576,
      brand: 'Bedsure',
      imagePaths: ['assets/Home_products/bath_and_bedding/bath3/1.png'],
    ),
    ProductsViewsModel(
      id: 'home19',
      title: 'Home of linen-fitted sheet set, size 120 * 200cm, offwhite',
      price: 369.00,
      originalPrice: 400.99,
      rating: 4.6,
      reviewCount: 4576,
      brand: 'Home of linen',
      imagePaths: ['assets/Home_products/bath_and_bedding/bath4/1.png'],
    ),
    ProductsViewsModel(
      id: 'home20',
      title:
          'Home of Linen - Duvet Cover Set - 3 Pieces for Double Bed - 1 Duvet Cover (185cm*235cm) + 2 Pillow Cases',
      price: 948.00,
      originalPrice: 1000.99,
      rating: 4.6,
      reviewCount: 4576,
      brand: 'Home of Linen',
      imagePaths: ['assets/Home_products/bath_and_bedding/bath5/1.png'],
    ),
  ];

  Widget _buildProductDetail(String productId) {
    switch (productId) {
      case 'home16':
        return const HomeProduct16();
      case 'home17':
        return const HomeProduct17();
      case 'home18':
        return const HomeProduct18();
      case 'home19':
        return const HomeProduct19();
      case 'home20':
        return const HomeProduct20();
      default:
        return const HomeProduct1();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseCategoryView(
      categoryName: 'Bath & Bedding',
      products: _products,
      productDetailBuilder: _buildProductDetail,
    );
  }
}
