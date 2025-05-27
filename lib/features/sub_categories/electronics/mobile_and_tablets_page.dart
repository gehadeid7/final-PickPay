import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/widgets/base_category_view.dart';
import 'package:pickpay/services/api_service.dart';
import 'package:pickpay/features/categories_pages/products_views/electronics_products_views/product1.dart';
import 'package:pickpay/features/categories_pages/products_views/electronics_products_views/product2.dart';
import 'package:pickpay/features/categories_pages/products_views/electronics_products_views/product3.dart';
import 'package:pickpay/features/categories_pages/products_views/electronics_products_views/product4.dart';
import 'package:pickpay/features/categories_pages/products_views/electronics_products_views/product5.dart';

class MobileAndTabletsPage extends StatefulWidget {
  const MobileAndTabletsPage({super.key});

  @override
  State<MobileAndTabletsPage> createState() => _MobileAndTabletsPageState();
}

class _MobileAndTabletsPageState extends State<MobileAndTabletsPage> {
  late Future<List<ProductsViewsModel>> _productsFuture;

  // Map of product detail pages
  static final Map<String, Widget> detailPages = {
    '6819e22b123a4faad16613be': const Product1View(), // iPhone 15 Pro Max
    '6819e22b123a4faad16613bf': const Product2View(), // Redmi Note 13
    '6819e22b123a4faad16613c0': const Product3View(), // Realme Note 50
    '6819e22b123a4faad16613c1': const Product4View(), // Galaxy Tab A8
    '6819e22b123a4faad16613c3': const Product5View(), // Samsung Galaxy Tab A9
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
            product.name.toLowerCase().contains('mobile') ||
            product.name.toLowerCase().contains('phone') ||
            product.name.toLowerCase().contains('tablet'))
        .map((apiProduct) {
          final productIndex =
              detailPages.keys.toList().indexOf(apiProduct.id) + 1;
          final imagePath =
              'assets/electronics_products/mobile_and_tablet/mobile_and_tablet$productIndex/1.png';

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
          categoryName: 'Mobile & Tablets',
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
