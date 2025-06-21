import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/widgets/base_category_view.dart';
import 'package:pickpay/features/categories_pages/products_views/appliances_products_views/appliances_product6.dart';
import 'package:pickpay/features/categories_pages/products_views/appliances_products_views/appliances_product7.dart';
import 'package:pickpay/features/categories_pages/products_views/appliances_products_views/appliances_product8.dart';
import 'package:pickpay/features/categories_pages/products_views/appliances_products_views/appliances_product9.dart';
import 'package:pickpay/features/categories_pages/products_views/appliances_products_views/appliances_product10.dart';
import 'package:pickpay/features/categories_pages/products_views/appliances_products_views/appliances_product12.dart';
import 'package:pickpay/features/categories_pages/products_views/appliances_products_views/appliances_product13.dart';
import 'package:pickpay/features/categories_pages/products_views/appliances_products_views/appliances_product14.dart';
import 'package:pickpay/features/categories_pages/products_views/appliances_products_views/appliances_product15.dart';
import 'package:pickpay/services/api_service.dart';

class SmallAppliances extends StatefulWidget {
  const SmallAppliances({super.key});

  @override
  State<SmallAppliances> createState() => _SmallAppliancesState();
}

class _SmallAppliancesState extends State<SmallAppliances> {
  late Future<List<ProductsViewsModel>> _productsFuture;

  // Map of product detail pages
  static final Map<String, Widget> detailPages = {
    '68252918a68b49cb06164209': const AppliancesProduct6(), // Air Fryer
    '68252918a68b49cb0616420a': const AppliancesProduct7(), // Coffee Maker
    '68252918a68b49cb0616420b': const AppliancesProduct8(), // Toaster
    '68252918a68b49cb0616420c': const AppliancesProduct9(), // Iron
    '68252918a68b49cb0616420d': const AppliancesProduct10(), // Vacuum Cleaner
    '68252918a68b49cb0616420f': const AppliancesProduct12(), // Water Heater
    '68252918a68b49cb06164210': const AppliancesProduct13(), // Blender
    '68252918a68b49cb06164211': const AppliancesProduct14(), // Kettle
    '68252918a68b49cb06164212': const AppliancesProduct15(), // Dough Mixer
  };

  // Map product IDs to their corresponding image numbers
  static final Map<String, int> productImageNumbers = {
    '68252918a68b49cb06164209': 6, // Air Fryer
    '68252918a68b49cb0616420a': 7, // Coffee Maker
    '68252918a68b49cb0616420b': 8, // Toaster
    '68252918a68b49cb0616420c': 9, // Iron
    '68252918a68b49cb0616420d': 10, // Vacuum Cleaner
    '68252918a68b49cb0616420f': 12, // Water Heater
    '68252918a68b49cb06164210': 13, // Blender
    '68252918a68b49cb06164211': 14, // Kettle
    '68252918a68b49cb06164212': 15, // Dough Mixer
  };

  @override
  void initState() {
    super.initState();
    _productsFuture = _loadProducts();
  }

  Future<List<ProductsViewsModel>> _loadProducts() async {
    final apiProducts = await ApiService().loadProducts();

    // Define actual brands for Small Appliances products
    final Map<String, String> productBrands = {
      '68252918a68b49cb06164209': 'deime', // AppliancesProduct6 - Air Fryer
      '68252918a68b49cb0616420a':
          'Black & Decker', // AppliancesProduct7 - Coffee Maker
      '68252918a68b49cb0616420b':
          'Black & Decker', // AppliancesProduct8 - Toaster
      '68252918a68b49cb0616420c': 'Panasonic', // AppliancesProduct9 - Iron
      '68252918a68b49cb0616420d':
          'Fresh', // AppliancesProduct10 - Vacuum Cleaner
      '68252918a68b49cb0616420f':
          'Tornado', // AppliancesProduct12 - Water Heater
      '68252918a68b49cb06164210':
          'Black & Decker', // AppliancesProduct13 - Blender
      '68252918a68b49cb06164211':
          'Black & Decker', // AppliancesProduct14 - Kettle
      '68252918a68b49cb06164212':
          'Black & Decker', // AppliancesProduct15 - Dough Mixer
    };

    final filteredProducts = apiProducts
        .where((apiProduct) => detailPages.containsKey(apiProduct.id))
        .map((apiProduct) {
      final productIndex = detailPages.keys.toList().indexOf(apiProduct.id) + 1;
      final imagePath = 'assets/appliances/product$productIndex/1.png';

      final assignedBrand = productBrands[apiProduct.id] ?? 'Generic';

      // Debug logging
      print(
          'Small Appliances - Product ID: ${apiProduct.id}, Assigned Brand: $assignedBrand');

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
    print('Small Appliances - Final brands in products: $finalBrands');

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
            'Small Appliances - Products passed to BaseCategoryView: ${products.length}');
        print(
            'Small Appliances - Brands in products: ${products.map((p) => p.brand).toSet()}');

        return BaseCategoryView(
          categoryName: 'Small Appliances',
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
