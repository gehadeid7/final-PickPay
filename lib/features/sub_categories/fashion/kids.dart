import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/widgets/base_category_view.dart';
import 'package:pickpay/features/categories_pages/products_views/fashion_products_views/fashion_product11.dart';
import 'package:pickpay/features/categories_pages/products_views/fashion_products_views/fashion_product12.dart';
import 'package:pickpay/features/categories_pages/products_views/fashion_products_views/fashion_product13.dart';
import 'package:pickpay/features/categories_pages/products_views/fashion_products_views/fashion_product14.dart';
import 'package:pickpay/features/categories_pages/products_views/fashion_products_views/fashion_product15.dart';
import 'package:pickpay/services/api_service.dart';

class Kids extends StatefulWidget {
  const Kids({super.key});

  @override
  State<Kids> createState() => _KidsState();
}

class _KidsState extends State<Kids> {
  late Future<List<ProductsViewsModel>> _productsFuture;

  // Map of product detail pages
  static final Map<String, Widget> detailPages = {
    '682b00c26977bd89257c0e98': const FashionProduct11(),
    '682b00c26977bd89257c0e99': const FashionProduct12(),
    '682b00c26977bd89257c0e9a': const FashionProduct13(),
    '682b00c26977bd89257c0e9b': const FashionProduct14(),
    '682b00c26977bd89257c0e9c': const FashionProduct15(),
  };

  @override
  void initState() {
    super.initState();
    _productsFuture = _loadProducts();
  }

  Future<List<ProductsViewsModel>> _loadProducts() async {
    final apiProducts = await ApiService().loadProducts();

    // Define actual brands for Kids' Fashion products
    final Map<String, String> productBrands = {
      '682b00c26977bd89257c0e98':
          'Carter\'s', // FashionProduct11 - Kids' Fashion
      '682b00c26977bd89257c0e99': 'OshKosh', // FashionProduct12 - Kids' Fashion
      '682b00c26977bd89257c0e9a':
          'Gap Kids', // FashionProduct13 - Kids' Fashion
      '682b00c26977bd89257c0e9b':
          'Old Navy Kids', // FashionProduct14 - Kids' Fashion
      '682b00c26977bd89257c0e9c':
          'Children\'s Place', // FashionProduct15 - Kids' Fashion
    };

    final filteredProducts = apiProducts
        .where((product) => detailPages.containsKey(product.id))
        .map((apiProduct) {
      final imagePath =
          'assets/Fashion_products/Kids_Fashion/kids_fashion${detailPages.keys.toList().indexOf(apiProduct.id) + 1}/1.png';

      final assignedBrand = productBrands[apiProduct.id] ?? 'Generic';

      // Debug logging
      print(
          'Kids\' Fashion - Product ID: ${apiProduct.id}, Assigned Brand: $assignedBrand');

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
    print('Kids\' Fashion - Final brands in products: $finalBrands');

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
          categoryName: "Kids' Fashion",
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
