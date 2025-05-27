import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/widgets/base_category_view.dart';
import 'package:pickpay/features/categories_pages/products_views/home_products/home_product1.dart';
import 'package:pickpay/features/categories_pages/products_views/home_products/home_product11.dart';
import 'package:pickpay/features/categories_pages/products_views/home_products/home_product12.dart';
import 'package:pickpay/features/categories_pages/products_views/home_products/home_product13.dart';
import 'package:pickpay/features/categories_pages/products_views/home_products/home_product14.dart';
import 'package:pickpay/features/categories_pages/products_views/home_products/home_product15.dart';

class Kitchenview extends StatelessWidget {
  Kitchenview({super.key});

  final List<ProductsViewsModel> _products = [
    ProductsViewsModel(
      id: 'home11',
      title: 'Neoflam Pote Cookware Set 11-Pieces, Pink Marble',
      price: 15795.00,
      originalPrice: 18989.00,
      rating: 4.8,
      reviewCount: 19,
      brand: 'Neoflam',
      imagePaths: ['assets/Home_products/kitchen/kitchen1/1.png'],
    ),
    ProductsViewsModel(
      id: 'home12',
      title: 'Pasabahce Set of 6 Large Mug with Handle -340ml Turkey Made',
      price: 495.00,
      originalPrice: 590.99,
      rating: 4.9,
      reviewCount: 1439,
      brand: 'Pasabahce',
      imagePaths: ['assets/Home_products/kitchen/kitchen2/1.png'],
    ),
    ProductsViewsModel(
      id: 'home13',
      title:
          'P&P CHEF 13½ Inch Pizza Pan Set, 3 Pack Nonstick Pizza Pans, Round Pizza Tray Bakeware for Oven Baking',
      price: 276.00,
      originalPrice: 300.00,
      rating: 4.5,
      reviewCount: 1162,
      brand: 'P&P CHEF',
      imagePaths: ['assets/Home_products/kitchen/kitchen3/1.png'],
    ),
    ProductsViewsModel(
      id: 'home14',
      title:
          'LIANYU 20 Piece Silverware Flatware Cutlery Set, Stainless Steel Utensils Service for 4',
      price: 50099.00,
      originalPrice: 69990.00,
      rating: 4.6,
      reviewCount: 1735,
      brand: 'LIANYU',
      imagePaths: ['assets/Home_products/kitchen/kitchen4/1.png'],
    ),
    ProductsViewsModel(
      id: 'home15',
      title:
          'Dish Rack Dish Drying Stand Dish Drainer Plate Rack Dish rake Kitchen Organizer',
      price: 400.00,
      originalPrice: 550.99,
      rating: 4.6,
      reviewCount: 4576,
      brand: 'Generic',
      imagePaths: ['assets/Home_products/kitchen/kitchen5/1.png'],
    ),
  ];

  Widget _buildProductDetail(String productId) {
    switch (productId) {
      case 'home11':
        return const HomeProduct11();
      case 'home12':
        return const HomeProduct12();
      case 'home13':
        return const HomeProduct13();
      case 'home14':
        return const HomeProduct14();
      case 'home15':
        return const HomeProduct15();
      default:
        return const HomeProduct1();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseCategoryView(
      categoryName: 'Kitchen & Dining',
      products: _products,
      productDetailBuilder: _buildProductDetail,
    );
  }
}
