import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/widgets/base_category_view.dart';
import 'package:pickpay/features/categories_pages/products_views/fashion_products_views/fashion_product1.dart';
import 'package:pickpay/features/categories_pages/products_views/fashion_products_views/fashion_product11.dart';
import 'package:pickpay/features/categories_pages/products_views/fashion_products_views/fashion_product12.dart';
import 'package:pickpay/features/categories_pages/products_views/fashion_products_views/fashion_product13.dart';
import 'package:pickpay/features/categories_pages/products_views/fashion_products_views/fashion_product14.dart';
import 'package:pickpay/features/categories_pages/products_views/fashion_products_views/fashion_product15.dart';

class Kids extends StatelessWidget {
  Kids({super.key});

  final List<ProductsViewsModel> _products = [
    ProductsViewsModel(
      id: '68132a95ff7813b3d47f9da11',
      title: "LC WAIKIKI Crew Neck Girl's Shorts Pajama Set",
      price: 261.00,
      originalPrice: 349.00,
      rating: 4.3,
      reviewCount: 11,
      brand: 'LC WAIKIKI',
      imagePaths: ["assets/Fashion_products/Kids_Fashion/kids_fashion1/1.png"],
    ),
    ProductsViewsModel(
      id: '68132a95ff7813b3d47f9da12',
      title: "Kidzo Boys Pajamas",
      price: 580.00,
      originalPrice: 621.00,
      rating: 5.0,
      reviewCount: 3,
      brand: 'Kidzo',
      imagePaths: ["assets/Fashion_products/Kids_Fashion/kids_fashion2/1.png"],
    ),
    ProductsViewsModel(
      id: '68132a95ff7813b3d47f9da13',
      title: "DeFacto Girls Cropped Fit Long Sleeve B9857A8 Denim Jacket",
      price: 899.00,
      originalPrice: 899.00,
      rating: 4.0,
      reviewCount: 19,
      brand: 'DeFacto',
      imagePaths: ["assets/Fashion_products/Kids_Fashion/kids_fashion3/1.png"],
    ),
    ProductsViewsModel(
      id: '68132a95ff7813b3d47f9da14',
      title:
          "Baby Boys Jacket Fashion Comfortable High Quality Plush Full Warmth Jacket for Your Baby",
      price: 425.00,
      originalPrice: 475.00,
      rating: 5.0,
      reviewCount: 19,
      brand: 'Generic',
      imagePaths: ["assets/Fashion_products/Kids_Fashion/kids_fashion4/1.png"],
    ),
    ProductsViewsModel(
      id: '68132a95ff7813b3d47f9da15',
      title: "MIX & MAX, Ballerina Shoes, girls, Ballet Flat",
      price: 354.65,
      originalPrice: 429.00,
      rating: 5.0,
      reviewCount: 19,
      brand: 'MIX & MAX',
      imagePaths: ["assets/Fashion_products/Kids_Fashion/kids_fashion5/1.png"],
    ),
  ];

  Widget _buildProductDetail(String productId) {
    switch (productId) {
      case '68132a95ff7813b3d47f9da11':
        return const FashionProduct11();
      case '68132a95ff7813b3d47f9da12':
        return const FashionProduct12();
      case '68132a95ff7813b3d47f9da13':
        return const FashionProduct13();
      case '68132a95ff7813b3d47f9da14':
        return const FashionProduct14();
      case '68132a95ff7813b3d47f9da15':
        return const FashionProduct15();
      default:
        return const FashionProduct1();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseCategoryView(
      categoryName: "Kids' Fashion",
      products: _products,
      productDetailBuilder: _buildProductDetail,
    );
  }
}
