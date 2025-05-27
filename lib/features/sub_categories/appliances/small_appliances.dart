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

  @override
  void initState() {
    super.initState();
    _productsFuture = _loadProducts();
  }

  Future<List<ProductsViewsModel>> _loadProducts() async {
    final apiProducts = await ApiService().loadProducts();
    return apiProducts
        .where((product) =>
            product.name.toLowerCase().contains('fryer') ||
            product.name.toLowerCase().contains('coffee') ||
            product.name.toLowerCase().contains('toaster') ||
            product.name.toLowerCase().contains('iron') ||
            product.name.toLowerCase().contains('vacuum') ||
            product.name.toLowerCase().contains('heater') ||
            product.name.toLowerCase().contains('blender') ||
            product.name.toLowerCase().contains('kettle') ||
            product.name.toLowerCase().contains('mixer'))
        .map((apiProduct) {
          final productIndex =
              detailPages.keys.toList().indexOf(apiProduct.id) + 1;
          final imagePath = 'assets/appliances/product$productIndex/1.png';

          return ProductsViewsModel(
            id: apiProduct.id,
            title: apiProduct.name,
            price: apiProduct.price,
            originalPrice: apiProduct.originalPrice,
            rating: 4.5,
            reviewCount: 100,
            brand: 'Generic',
            imagePaths: [imagePath],
            soldBy: 'PickPay',
            isPickPayFulfilled: true,
            hasFreeDelivery: true,
          );
        })
        .where((product) => detailPages.containsKey(product.id))
        .toList();
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
