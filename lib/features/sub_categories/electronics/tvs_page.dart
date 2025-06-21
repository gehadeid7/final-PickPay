import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/widgets/base_category_view.dart';
import 'package:pickpay/services/api_service.dart';
import 'package:pickpay/features/categories_pages/products_views/electronics_products_views/product6.dart';
import 'package:pickpay/features/categories_pages/products_views/electronics_products_views/product7.dart';
import 'package:pickpay/features/categories_pages/products_views/electronics_products_views/product8.dart';
import 'package:pickpay/features/categories_pages/products_views/electronics_products_views/product9.dart';
import 'package:pickpay/features/categories_pages/products_views/electronics_products_views/product10.dart';

class TvsPage extends StatefulWidget {
  const TvsPage({super.key});

  @override
  State<TvsPage> createState() => _TvsPageState();
}

class _TvsPageState extends State<TvsPage> {
  late Future<List<ProductsViewsModel>> _productsFuture;

  // Map of product detail pages
  static final Map<String, Widget> detailPages = {
    '6819e22b123a4faad16613c4': const Product6View(), // Samsung QLED TV
    '6819e22b123a4faad16613c5': const Product7View(), // Xiaomi TV
    '6819e22b123a4faad16613c6': const Product8View(), // Samsung Crystal TV
    '6819e22b123a4faad16613c7': const Product9View(), // Sharp TV
    '6819e22b123a4faad16613c8': const Product10View(), // LG TV
  };

  @override
  void initState() {
    super.initState();
    _productsFuture = _loadProducts();
  }

  Future<List<ProductsViewsModel>> _loadProducts() async {
    final apiProducts = await ApiService().loadProducts();

    // Define actual brands for TVs products
    final Map<String, String> productBrands = {
      '6819e22b123a4faad16613c4': 'SAMSUNG', // TV1
      '6819e22b123a4faad16613c5': 'SAMSUNG', // TV2
      '6819e22b123a4faad16613c6': 'SAMSUNG', // TV3
      '6819e22b123a4faad16613c7': 'SAMSUNG', // TV4
      '6819e22b123a4faad16613c8': 'LG', // TV5 - LG UHD 4K TV
    };

    return apiProducts
        .where((apiProduct) => detailPages.containsKey(apiProduct.id))
        .map((apiProduct) {
      final productIndex = detailPages.keys.toList().indexOf(apiProduct.id) + 1;
      final imagePath =
          'assets/electronics_products/tvscreens/tv$productIndex/1.png';

      return ProductsViewsModel(
        id: apiProduct.id,
        title: apiProduct.name,
        price: apiProduct.price,
        originalPrice: apiProduct.originalPrice,
        rating: 4.5,
        reviewCount: 100,
        brand: productBrands[apiProduct.id] ?? 'Generic', // Use actual brand
        imagePaths: [imagePath],
        soldBy: 'PickPay',
        isPickPayFulfilled: true,
        hasFreeDelivery: true,
      );
    }).toList();
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
          categoryName: 'TVs',
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
