import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/widgets/base_category_view.dart';
import 'package:pickpay/features/categories_pages/products_views/appliances_products_views/appliances_product1.dart';
import 'package:pickpay/features/categories_pages/products_views/appliances_products_views/appliances_product2.dart';
import 'package:pickpay/features/categories_pages/products_views/appliances_products_views/appliances_product3.dart';
import 'package:pickpay/features/categories_pages/products_views/appliances_products_views/appliances_product4.dart';
import 'package:pickpay/features/categories_pages/products_views/appliances_products_views/appliances_product5.dart';
import 'package:pickpay/services/api_service.dart';

class LargeAppliances extends StatefulWidget {
  const LargeAppliances({super.key});

  @override
  State<LargeAppliances> createState() => _LargeAppliancesState();
}

class _LargeAppliancesState extends State<LargeAppliances> {
  late Future<List<ProductsViewsModel>> _productsFuture;

  // Map of product detail pages
  static final Map<String, Widget> detailPages = {
    '68252918a68b49cb06164204': const AppliancesProduct1(), // Water Dispenser
    '68252918a68b49cb06164205': const AppliancesProduct2(), // Stainless Steel
    '68252918a68b49cb06164206': const AppliancesProduct3(), // Refrigerator
    '68252918a68b49cb06164207': const AppliancesProduct4(), // Washing Machine
    '68252918a68b49cb06164208': const AppliancesProduct5(), // Dishwasher
  };

  // Map product IDs to their corresponding image numbers
  static final Map<String, int> productImageNumbers = {
    '68252918a68b49cb06164204': 1, // Water Dispenser
    '68252918a68b49cb06164205': 2, // Stainless Steel Cooker
    '68252918a68b49cb06164206': 3, // Refrigerator
    '68252918a68b49cb06164207': 4, // Washing Machine
    '68252918a68b49cb06164208': 5, // Dishwasher
  };

  @override
  void initState() {
    super.initState();
    _productsFuture = _loadProducts();
  }

  Future<List<ProductsViewsModel>> _loadProducts() async {
    final apiProducts = await ApiService().loadProducts();

    // Define actual brands for Large Appliances products
    final Map<String, String> productBrands = {
      '68252918a68b49cb06164204':
          'Koldair', // AppliancesProduct1 - Water Dispenser
      '68252918a68b49cb06164205':
          'Fresh', // AppliancesProduct2 - Washing Machine
      '68252918a68b49cb06164206': 'Midea', // AppliancesProduct3 - Refrigerator
      '68252918a68b49cb06164207':
          'Zanussi', // AppliancesProduct4 - Washing Machine
      '68252918a68b49cb06164208': 'Midea', // AppliancesProduct5 - Dishwasher
    };

    final filteredProducts = apiProducts
        .where((apiProduct) => detailPages.containsKey(apiProduct.id))
        .map((apiProduct) {
      final productNumber = productImageNumbers[apiProduct.id] ?? 1;
      final imagePath = 'assets/appliances/product$productNumber/1.png';

      final assignedBrand = productBrands[apiProduct.id] ?? 'Generic';

      // Debug logging
      print(
          'Large Appliances - Product ID: ${apiProduct.id}, Product Number: $productNumber, Assigned Brand: $assignedBrand');

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
    print('Large Appliances - Final brands in products: $finalBrands');

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
            'Large Appliances - Products passed to BaseCategoryView: ${products.length}');
        print(
            'Large Appliances - Brands in products: ${products.map((p) => p.brand).toSet()}');

        return BaseCategoryView(
          categoryName: 'Large Appliances',
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
