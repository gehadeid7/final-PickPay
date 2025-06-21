import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/widgets/base_category_view.dart';
import 'package:pickpay/features/categories_pages/products_views/home_products/home_product1.dart';
import 'package:pickpay/features/categories_pages/products_views/home_products/home_product2.dart';
import 'package:pickpay/features/categories_pages/products_views/home_products/home_product3.dart';
import 'package:pickpay/features/categories_pages/products_views/home_products/home_product4.dart';
import 'package:pickpay/features/categories_pages/products_views/home_products/home_product5.dart';
import 'package:pickpay/services/api_service.dart';

class FurnitureView extends StatefulWidget {
  const FurnitureView({super.key});

  @override
  State<FurnitureView> createState() => _FurnitureViewState();
}

class _FurnitureViewState extends State<FurnitureView> {
  late Future<List<ProductsViewsModel>> _productsFuture;

  // Map of product detail pages
  static final Map<String, Widget> detailPages = {
    '681dab0df9c9147444b452cd': const HomeProduct1(),
    '681dab0df9c9147444b452ce': const HomeProduct2(),
    '681dab0df9c9147444b452cf': const HomeProduct3(),
    '681dab0df9c9147444b452d0': const HomeProduct4(),
    '681dab0df9c9147444b452d1': const HomeProduct5(),
  };

  @override
  void initState() {
    super.initState();
    _productsFuture = _loadProducts();
  }

  Future<List<ProductsViewsModel>> _loadProducts() async {
    final apiProducts = await ApiService().loadProducts();

    // Define actual brands for Furniture products
    final Map<String, String> productBrands = {
      '681dab0df9c9147444b452cd': 'Generic', // HomeProduct1 - Furniture
      '681dab0df9c9147444b452ce': 'Generic', // HomeProduct2 - Furniture
      '681dab0df9c9147444b452cf': 'Generic', // HomeProduct3 - Furniture
      '681dab0df9c9147444b452d0': 'Furgle', // HomeProduct4 - Furniture
      '681dab0df9c9147444b452d1': 'Janssen', // HomeProduct5 - Furniture
    };

    final filteredProducts = apiProducts
        .where((apiProduct) => detailPages.containsKey(apiProduct.id))
        .map((apiProduct) {
      final productIndex = detailPages.keys.toList().indexOf(apiProduct.id) + 1;
      final imagePath =
          'assets/Home_products/furniture/furniture$productIndex/1.png';

      final assignedBrand = productBrands[apiProduct.id] ?? 'Generic';

      // Debug logging
      print(
          'Furniture - Product ID: ${apiProduct.id}, Assigned Brand: $assignedBrand');

      return ProductsViewsModel(
        id: apiProduct.id,
        title: apiProduct.name,
        price: apiProduct.price,
        originalPrice: apiProduct.originalPrice,
        rating: 4.5,
        reviewCount: 100,
        brand: assignedBrand, // Use actual brand
        imagePaths: [imagePath],
        soldBy: 'PickPay',
        isPickPayFulfilled: true,
        hasFreeDelivery: true,
      );
    }).toList();

    // Debug logging for final brands
    final finalBrands = filteredProducts.map((p) => p.brand).toSet();
    print('Furniture - Final brands in products: $finalBrands');

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

        // Debug logging for products passed to BaseCategoryView
        print(
            'Furniture - Products passed to BaseCategoryView: ${products.length}');
        print(
            'Furniture - Brands in products: ${products.map((p) => p.brand).toSet()}');

        return BaseCategoryView(
          categoryName: 'Furniture',
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
