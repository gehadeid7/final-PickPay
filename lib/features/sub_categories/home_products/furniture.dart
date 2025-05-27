import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/widgets/base_category_view.dart';
import 'package:pickpay/features/categories_pages/products_views/home_products/home_product1.dart';
import 'package:pickpay/features/categories_pages/products_views/home_products/home_product2.dart';
import 'package:pickpay/features/categories_pages/products_views/home_products/home_product3.dart';
import 'package:pickpay/features/categories_pages/products_views/home_products/home_product4.dart';
import 'package:pickpay/features/categories_pages/products_views/home_products/home_product5.dart';

class FurnitureView extends StatelessWidget {
  FurnitureView({super.key});

  final List<ProductsViewsModel> _products = [
    ProductsViewsModel(
      id: 'home1',
      title: 'Golden Life Sofa Bed - Size 190 cm - Beige',
      price: 7850.00,
      originalPrice: 0,
      rating: 5.0,
      reviewCount: 88,
      brand: 'Golden Life',
      imagePaths: ['assets/Home_products/furniture/furniture1/1.png'],
    ),
    ProductsViewsModel(
      id: 'home2',
      title: 'Star Bags Bean Bag Chair - Purple, 95*95*97 cm, Unisex Adults',
      price: 1699.00,
      originalPrice: 2499.00,
      rating: 5.0,
      reviewCount: 88,
      brand: 'Star Bags',
      imagePaths: ['assets/Home_products/furniture/furniture2/1.png'],
    ),
    ProductsViewsModel(
      id: 'home3',
      title: 'Generic Coffee Table, Round, 71 cm x 45 cm, Black',
      price: 3600.00,
      originalPrice: 0,
      rating: 5.0,
      reviewCount: 88,
      brand: 'Generic',
      imagePaths: ['assets/Home_products/furniture/furniture3/1.png'],
    ),
    ProductsViewsModel(
      id: 'home4',
      title: 'Gaming Chair, Furgle Gocker Ergonomic Adjustable 3D Swivel Chair',
      price: 9696.55,
      originalPrice: 12071.00,
      rating: 5.0,
      reviewCount: 92,
      brand: 'Furgle',
      imagePaths: ['assets/Home_products/furniture/furniture4/1.png'],
    ),
    ProductsViewsModel(
      id: 'home5',
      title: 'Janssen Almany Innerspring Mattress Height 25 cm - 120 x 195 cm',
      price: 5060.03,
      originalPrice: 0,
      rating: 5.0,
      reviewCount: 88,
      brand: 'Janssen',
      imagePaths: ['assets/Home_products/furniture/furniture5/1.png'],
    ),
  ];

  Widget _buildProductDetail(String productId) {
    switch (productId) {
      case 'home1':
        return const HomeProduct1();
      case 'home2':
        return const HomeProduct2();
      case 'home3':
        return const HomeProduct3();
      case 'home4':
        return const HomeProduct4();
      case 'home5':
        return const HomeProduct5();
      default:
        return const HomeProduct1();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseCategoryView(
      categoryName: 'Furniture',
      products: _products,
      productDetailBuilder: _buildProductDetail,
    );
  }
}
