import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/widgets/base_category_view.dart';
import 'package:pickpay/features/categories_pages/products_views/fashion_products_views/fashion_product1.dart';
import 'package:pickpay/features/categories_pages/products_views/fashion_products_views/fashion_product2.dart';
import 'package:pickpay/features/categories_pages/products_views/fashion_products_views/fashion_product3.dart';
import 'package:pickpay/features/categories_pages/products_views/fashion_products_views/fashion_product4.dart';
import 'package:pickpay/features/categories_pages/products_views/fashion_products_views/fashion_product5.dart';

class Women extends StatelessWidget {
  Women({super.key});

  final List<ProductsViewsModel> _products = [
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
      default:
        return const FashionProduct1();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseCategoryView(
      categoryName: "Women's Fashion",
      products: _products,
      productDetailBuilder: _buildProductDetail,
    );
  }
}
