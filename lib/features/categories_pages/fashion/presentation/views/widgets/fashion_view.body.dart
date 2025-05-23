import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/widgets/base_category_view.dart';
import 'package:pickpay/features/categories_pages/products_views/fashion_products_views/fashion_product1.dart';
import 'package:pickpay/features/categories_pages/products_views/fashion_products_views/fashion_product2.dart';
import 'package:pickpay/features/categories_pages/products_views/fashion_products_views/fashion_product3.dart';
import 'package:pickpay/features/categories_pages/products_views/fashion_products_views/fashion_product4.dart';
import 'package:pickpay/features/categories_pages/products_views/fashion_products_views/fashion_product5.dart';
import 'package:pickpay/features/categories_pages/products_views/fashion_products_views/fashion_product6.dart';
import 'package:pickpay/features/categories_pages/products_views/fashion_products_views/fashion_product7.dart';
import 'package:pickpay/features/categories_pages/products_views/fashion_products_views/fashion_product8.dart';
import 'package:pickpay/features/categories_pages/products_views/fashion_products_views/fashion_product9.dart';
import 'package:pickpay/features/categories_pages/products_views/fashion_products_views/fashion_product10.dart';
import 'package:pickpay/features/categories_pages/products_views/fashion_products_views/fashion_product11.dart';
import 'package:pickpay/features/categories_pages/products_views/fashion_products_views/fashion_product12.dart';
import 'package:pickpay/features/categories_pages/products_views/fashion_products_views/fashion_product13.dart';
import 'package:pickpay/features/categories_pages/products_views/fashion_products_views/fashion_product14.dart';
import 'package:pickpay/features/categories_pages/products_views/fashion_products_views/fashion_product15.dart';

class FashionViewBody extends StatelessWidget {
  FashionViewBody({super.key});

  final List<ProductsViewsModel> _fashionProducts = [
    ProductsViewsModel(
      id: '68132a95ff7813b3d47f9da1',
      title: "Women's Chiffon Lining Batwing Sleeve Dress",
      price: 850.00,
      originalPrice: 970.00,
      rating: 5.0,
      reviewCount: 88,
      brand: 'Generic',
      imagePaths: [
        "assets/Fashion_products/Women_Fashion/women_fashion1/1.png"
      ],
    ),
    ProductsViewsModel(
      id: '68132a95ff7813b3d47f9da2',
      title: "adidas womens ULTIMASHOW Shoes",
      price: 1456.53,
      originalPrice: 2188.06,
      rating: 5.0,
      reviewCount: 88,
      brand: 'Adidas',
      imagePaths: [
        "assets/Fashion_products/Women_Fashion/women_fashion2/1.png"
      ],
    ),
    ProductsViewsModel(
      id: '68132a95ff7813b3d47f9da3',
      title: "American Eagle Womens Low-Rise Baggy Wide-Leg Jean",
      price: 2700.00,
      originalPrice: 0,
      rating: 5.0,
      reviewCount: 88,
      brand: 'American Eagle',
      imagePaths: [
        "assets/Fashion_products/Women_Fashion/women_fashion3/1.png"
      ],
    ),
    ProductsViewsModel(
      id: '68132a95ff7813b3d47f9da4',
      title: "Dejavu womens JAL-DJTF-058 Sandal",
      price: 1399.00,
      originalPrice: 0,
      rating: 5.0,
      reviewCount: 92,
      brand: 'Dejavu',
      imagePaths: [
        "assets/Fashion_products/Women_Fashion/women_fashion4/1.png"
      ],
    ),
    ProductsViewsModel(
      id: '68132a95ff7813b3d47f9da5',
      title: "Aldo Caraever Ladies Satchel Handbags, Khaki, Khaki",
      price: 799.00,
      originalPrice: 0,
      rating: 5.0,
      reviewCount: 88,
      brand: 'Aldo',
      imagePaths: [
        "assets/Fashion_products/Women_Fashion/women_fashion5/1.png"
      ],
    ),
    ProductsViewsModel(
      id: '68132a95ff7813b3d47f9da6',
      title:
          "DeFacto Man Modern Fit Polo Neck Short Sleeve B6374AX Polo T-Shirt",
      price: 352.00,
      originalPrice: 899.00,
      rating: 4.0,
      reviewCount: 19,
      brand: 'DeFacto',
      imagePaths: ["assets/Fashion_products/Men_Fashion/men_fashion1/1.png"],
    ),
    ProductsViewsModel(
      id: '68132a95ff7813b3d47f9da7',
      title: "DOTT JEANS WEAR Men's Relaxed Fit Jeans",
      price: 718.30,
      originalPrice: 799.00,
      rating: 4.0,
      reviewCount: 19,
      brand: 'DOTT',
      imagePaths: ["assets/Fashion_products/Men_Fashion/men_fashion2/1.png"],
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
      case '68132a95ff7813b3d47f9da1':
        return const FashionProduct1();
      case '68132a95ff7813b3d47f9da2':
        return const FashionProduct2();
      case '68132a95ff7813b3d47f9da3':
        return const FashionProduct3();
      case '68132a95ff7813b3d47f9da4':
        return const FashionProduct4();
      case '68132a95ff7813b3d47f9da5':
        return const FashionProduct5();
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
      categoryName: 'Fashion',
      products: _fashionProducts,
      productDetailBuilder: _buildProductDetail,
    );
  }
}
