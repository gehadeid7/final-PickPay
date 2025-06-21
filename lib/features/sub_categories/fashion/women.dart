import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/widgets/base_category_view.dart';
import 'package:pickpay/features/categories_pages/products_views/fashion_products_views/fashion_product1.dart';
import 'package:pickpay/features/categories_pages/products_views/fashion_products_views/fashion_product2.dart';
import 'package:pickpay/features/categories_pages/products_views/fashion_products_views/fashion_product3.dart';
import 'package:pickpay/features/categories_pages/products_views/fashion_products_views/fashion_product4.dart';
import 'package:pickpay/features/categories_pages/products_views/fashion_products_views/fashion_product5.dart';
import 'package:pickpay/services/api_service.dart';

class Women extends StatefulWidget {
  const Women({super.key});

  @override
  State<Women> createState() => _WomenState();
}

class _WomenState extends State<Women> {
  late Future<List<ProductsViewsModel>> _productsFuture;

  // Map of product detail pages
  static final Map<String, Widget> detailPages = {
    '682b00c26977bd89257c0e8e': const FashionProduct1(),
    '682b00c26977bd89257c0e8f': const FashionProduct2(),
    '682b00c26977bd89257c0e90': const FashionProduct3(),
    '682b00c26977bd89257c0e91': const FashionProduct4(),
    '682b00c26977bd89257c0e92': const FashionProduct5(),
  };

  @override
  void initState() {
    super.initState();
    _productsFuture = _loadProducts();
  }

  Future<List<ProductsViewsModel>> _loadProducts() async {
    final apiProducts = await ApiService().loadProducts();

    // Define actual brands for Women's Fashion products
    final Map<String, String> productBrands = {
      '682b00c26977bd89257c0e8e': 'Zara', // FashionProduct1 - Women's Fashion
      '682b00c26977bd89257c0e8f': 'H&M', // FashionProduct2 - Women's Fashion
      '682b00c26977bd89257c0e90':
          'Forever 21', // FashionProduct3 - Women's Fashion
      '682b00c26977bd89257c0e91': 'Mango', // FashionProduct4 - Women's Fashion
      '682b00c26977bd89257c0e92': 'Uniqlo', // FashionProduct5 - Women's Fashion
    };

    final filteredProducts = apiProducts
        .where((product) => detailPages.containsKey(product.id))
        .map((apiProduct) {
      final imagePath =
          'assets/Fashion_products/Women_Fashion/women_fashion${detailPages.keys.toList().indexOf(apiProduct.id) + 1}/1.png';

      final assignedBrand = productBrands[apiProduct.id] ?? 'Generic';

      // Debug logging
      print(
          'Women\'s Fashion - Product ID: ${apiProduct.id}, Assigned Brand: $assignedBrand');

      return ProductsViewsModel(
        id: apiProduct.id,
        title: apiProduct.name,
        price: apiProduct.price,
        originalPrice: apiProduct.originalPrice,
        rating: apiProduct.rating ?? 4.5,
        reviewCount: apiProduct.reviewCount ?? 100,
        brand: assignedBrand, // Use actual brand
        imagePaths: [imagePath],
        soldBy: 'PickPay',
        isPickPayFulfilled: true,
        hasFreeDelivery: true,
      );
    }).toList();

    // Debug logging for final brands
    final finalBrands = filteredProducts.map((p) => p.brand).toSet();
    print('Women\'s Fashion - Final brands in products: $finalBrands');

    return filteredProducts;
  }

  Widget? _findDetailPageById(String productId) {
    return detailPages[productId];
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ProductsViewsModel>>(
      future: _productsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        final products = snapshot.data ?? [];

        return BaseCategoryView(
          categoryName: "Women's Fashion",
          products: products,
          productDetailBuilder: (String productId) {
            final detailPage = _findDetailPageById(productId);
            if (detailPage != null) {
              return detailPage;
            }
            return const Scaffold(
              body: Center(child: Text('Product detail view coming soon')),
            );
          },
        );
      },
    );
  }
}
