import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/widgets/base_category_view.dart';
import 'package:pickpay/features/categories_pages/products_views/beauty_products_views/beauty_product1.dart';
import 'package:pickpay/features/categories_pages/products_views/beauty_products_views/beauty_product2.dart';
import 'package:pickpay/features/categories_pages/products_views/beauty_products_views/beauty_product3.dart';
import 'package:pickpay/features/categories_pages/products_views/beauty_products_views/beauty_product4.dart';
import 'package:pickpay/features/categories_pages/products_views/beauty_products_views/beauty_product5.dart';

class Makeup extends StatelessWidget {
  Makeup({super.key});

  final List<ProductsViewsModel> _products = [
    ProductsViewsModel(
      id: '68132a95ff7813b3d47f9da1',
      title:
          "L'Oréal Paris Volume Million Lashes Panorama Mascara in Black, 9.9 ml",
      price: 401.00,
      originalPrice: 730.00,
      rating: 5.0,
      reviewCount: 88,
      brand: 'L\'Oréal Paris',
      imagePaths: ['assets/beauty_products/makeup_1/1.png'],
    ),
    ProductsViewsModel(
      id: '68132a95ff7813b3d47f9da2',
      title:
          'L\'Oréal Paris Infaillible 24H Matte Cover Foundation 200 Sable Dore - Oil Control, High Coverage',
      price: 509.00,
      originalPrice: 575.00,
      rating: 5.0,
      reviewCount: 88,
      brand: 'L\'Oréal Paris',
      imagePaths: ['assets/beauty_products/makeup_2/1.png'],
    ),
    ProductsViewsModel(
      id: '68132a95ff7813b3d47f9da3',
      title: 'Cybele Smooth N`Wear Powder Blush Corail 17 - 3.7gm',
      price: 227.20,
      originalPrice: 240.00,
      rating: 5.0,
      reviewCount: 88,
      brand: 'Cybele',
      imagePaths: ['assets/beauty_products/makeup_3/1.png'],
    ),
    ProductsViewsModel(
      id: '68132a95ff7813b3d47f9da4',
      title:
          'Eva skin care cleansing & makeup remover facial wipes for normal/dry skin 20%',
      price: 63.00,
      originalPrice: 63.00,
      rating: 5.0,
      reviewCount: 92,
      brand: 'Eva',
      imagePaths: ['assets/beauty_products/makeup_4/1.png'],
    ),
    ProductsViewsModel(
      id: '68132a95ff7813b3d47f9da5',
      title: 'Maybelline New York Lifter Lip Gloss, 005 Petal',
      price: 300.00,
      originalPrice: 310.00,
      rating: 5.0,
      reviewCount: 88,
      brand: 'Maybelline',
      imagePaths: ['assets/beauty_products/makeup_5/1.png'],
    ),
  ];

  Widget _buildProductDetail(String productId) {
    switch (productId) {
      case '68132a95ff7813b3d47f9da1':
        return const BeautyProduct1();
      case '68132a95ff7813b3d47f9da2':
        return const BeautyProduct2();
      case '68132a95ff7813b3d47f9da3':
        return const BeautyProduct3();
      case '68132a95ff7813b3d47f9da4':
        return const BeautyProduct4();
      case '68132a95ff7813b3d47f9da5':
        return const BeautyProduct5();
      default:
        return const BeautyProduct1();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseCategoryView(
      categoryName: "Makeup",
      products: _products,
      productDetailBuilder: _buildProductDetail,
    );
  }
}
