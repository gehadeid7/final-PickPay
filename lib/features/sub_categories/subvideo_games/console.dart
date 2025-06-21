import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/widgets/base_category_view.dart';
import 'package:pickpay/features/categories_pages/products_views/video_games/video_games_product1.dart';
import 'package:pickpay/features/categories_pages/products_views/video_games/video_games_product2.dart';
import 'package:pickpay/features/categories_pages/products_views/video_games/video_games_product3.dart';
import 'package:pickpay/features/categories_pages/products_views/video_games/video_games_product4.dart';
import 'package:pickpay/services/api_service.dart';

class Console extends StatefulWidget {
  const Console({super.key});

  @override
  State<Console> createState() => _ConsoleState();
}

class _ConsoleState extends State<Console> {
  late Future<List<ProductsViewsModel>> _productsFuture;

  // Map of product detail pages
  static final Map<String, Widget> detailPages = {
    '682b00a46977bd89257c0e80': const VideoGamesProduct1(),
    '682b00a46977bd89257c0e81': const VideoGamesProduct2(),
    '682b00a46977bd89257c0e82': const VideoGamesProduct3(),
    '682b00a46977bd89257c0e83': const VideoGamesProduct4(),
  };

  @override
  void initState() {
    super.initState();
    _productsFuture = _loadProducts();
  }

  Future<List<ProductsViewsModel>> _loadProducts() async {
    final apiProducts = await ApiService().loadProducts();

    // Define actual brands for Video Game Console products
    final Map<String, String> productBrands = {
      '682b00a46977bd89257c0e80': 'PlayStation', // VideoGamesProduct1 - Console
      '682b00a46977bd89257c0e81': 'Nintendo', // VideoGamesProduct2 - Console
      '682b00a46977bd89257c0e82': 'Generic', // VideoGamesProduct3 - Console
      '682b00a46977bd89257c0e83': 'Generic', // VideoGamesProduct4 - Console
    };

    final filteredProducts = apiProducts
        .where((product) => detailPages.containsKey(product.id))
        .map((apiProduct) {
      final imagePath =
          'assets/videogames_products/Consoles/console${detailPages.keys.toList().indexOf(apiProduct.id) + 1}/1.png';

      final assignedBrand = productBrands[apiProduct.id] ?? 'Generic';

      // Debug logging
      print(
          'Video Game Console - Product ID: ${apiProduct.id}, Assigned Brand: $assignedBrand');

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
    print('Video Game Console - Final brands in products: $finalBrands');

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
          categoryName: 'Console',
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
