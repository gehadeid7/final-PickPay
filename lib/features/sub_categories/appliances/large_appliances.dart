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

  @override
  void initState() {
    super.initState();
    _productsFuture = _loadProducts();
  }

  Future<List<ProductsViewsModel>> _loadProducts() async {
    final apiProducts = await ApiService().loadProducts();
    return apiProducts
        .where((product) =>
            product.name.toLowerCase().contains('refrigerator') ||
            product.name.toLowerCase().contains('washing machine') ||
            product.name.toLowerCase().contains('dispenser') ||
            product.name.toLowerCase().contains('dishwasher') ||
            product.name.toLowerCase().contains('jumbo'))
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
