import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/widgets/base_category_view.dart';
import 'package:pickpay/features/categories_pages/products_views/fashion_products_views/fashion_product1.dart';
import 'package:pickpay/features/categories_pages/products_views/fashion_products_views/fashion_product6.dart';
import 'package:pickpay/features/categories_pages/products_views/fashion_products_views/fashion_product7.dart';
import 'package:pickpay/features/categories_pages/products_views/fashion_products_views/fashion_product8.dart';
import 'package:pickpay/features/categories_pages/products_views/fashion_products_views/fashion_product9.dart';
import 'package:pickpay/features/categories_pages/products_views/fashion_products_views/fashion_product10.dart';

class Men extends StatelessWidget {
  Men({super.key});

  final List<ProductsViewsModel> _products = [
    ProductsViewsModel(
      id: '68132a95ff7813b3d47f9da6',
      title:
          "DeFacto Man Modern Fit Polo Neck Short Sleeve B6374AX Polo T-Shirt",
      price: 352.00,
      originalPrice: 899.00,
      rating: 4.0,
      reviewCount: 19,
      brand: 'DeFacto',
      imagePaths: [
        "assets/Fashion_products/Men_Fashion/men_fashion1/navy/1.png"
      ],
    ),
    ProductsViewsModel(
      id: '68132a95ff7813b3d47f9da7',
      title: "DOTT JEANS WEAR Men's Relaxed Fit Jeans",
      price: 718.30,
      originalPrice: 799.00,
      rating: 4.0,
      reviewCount: 19,
      brand: 'DOTT',
      imagePaths: [
        "assets/Fashion_products/Men_Fashion/men_fashion2/light_blue/1.png"
      ],
    ),
    ProductsViewsModel(
      id: '68132a95ff7813b3d47f9da8',
      title:
          "Sport-Q®Fury-X Latest Model Football Shoes X Football Shoes Combining Comfort Precision and Performance Excellence in Game.",
      price: 269.00,
      originalPrice: 299.00,
      rating: 4.0,
      reviewCount: 19,
      brand: 'Sport-Q',
      imagePaths: ["assets/Fashion_products/Men_Fashion/men_fashion3/1.png"],
    ),
    ProductsViewsModel(
      id: '68132a95ff7813b3d47f9da9',
      title: "Timberland Ek Larchmont Ftm_Chelsea, Men's Boots",
      price: 10499.00,
      originalPrice: 11000.00,
      rating: 4.3,
      reviewCount: 57,
      brand: 'Timberland',
      imagePaths: ["assets/Fashion_products/Men_Fashion/men_fashion4/1.png"],
    ),
    ProductsViewsModel(
      id: '68132a95ff7813b3d47f9da10',
      title:
          "Timberland Men's Leather Trifold Wallet Hybrid, Brown/Black, One Size",
      price: 1399.00,
      originalPrice: 1511.00,
      rating: 4.6,
      reviewCount: 1118,
      brand: 'Timberland',
      imagePaths: ["assets/Fashion_products/Men_Fashion/men_fashion5/1.png"],
    ),
  ];

  Widget _buildProductDetail(String productId) {
    switch (productId) {
      case '68132a95ff7813b3d47f9da6':
        return const FashionProduct6();
      case '68132a95ff7813b3d47f9da7':
        return const FashionProduct7();
      case '68132a95ff7813b3d47f9da8':
        return const FashionProduct8();
      case '68132a95ff7813b3d47f9da9':
        return const FashionProduct9();
      case '68132a95ff7813b3d47f9da10':
        return const FashionProduct10();
      default:
        return const FashionProduct1();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseCategoryView(
      categoryName: "Men's Fashion",
      products: _products,
      productDetailBuilder: _buildProductDetail,
    );
  }
}
