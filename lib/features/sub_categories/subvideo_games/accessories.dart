import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/widgets/base_category_view.dart';
import 'package:pickpay/features/categories_pages/products_views/video_games/video_games_product10.dart';
import 'package:pickpay/features/categories_pages/products_views/video_games/video_games_product11.dart';
import 'package:pickpay/features/categories_pages/products_views/video_games/video_games_product12.dart';
import 'package:pickpay/features/categories_pages/products_views/video_games/video_games_product13.dart';
import 'package:pickpay/features/categories_pages/products_views/video_games/video_games_product14.dart';
import 'package:pickpay/services/api_service.dart';

class Accessories extends StatefulWidget {
  const Accessories({super.key});

  @override
  State<Accessories> createState() => _AccessoriesState();
}

class _AccessoriesState extends State<Accessories> {
  late Future<List<ProductsViewsModel>> _productsFuture;

  // Map of product detail pages
  static final Map<String, Widget> detailPages = {
    '682b00a46977bd89257c0e89': const VideoGamesProduct10(),
    '682b00a46977bd89257c0e8a': const VideoGamesProduct11(),
    '682b00a46977bd89257c0e8b': const VideoGamesProduct12(),
    '682b00a46977bd89257c0e8c': const VideoGamesProduct13(),
    '682b00a46977bd89257c0e8d': const VideoGamesProduct14(),
  };

  @override
  void initState() {
    super.initState();
    _productsFuture = _loadProducts();
  }

  Future<List<ProductsViewsModel>> _loadProducts() async {
    final apiProducts = await ApiService().loadProducts();

    // Define actual brands for Video Game Accessories products
    final Map<String, String> productBrands = {
      '682b00a46977bd89257c0e89':
          'Likorlove', // VideoGamesProduct10 - Accessories
      '682b00a46977bd89257c0e8a':
          'fanxiang', // VideoGamesProduct11 - Accessories
      '682b00a46977bd89257c0e8b':
          'Mcbazel', // VideoGamesProduct12 - Accessories
      '682b00a46977bd89257c0e8c':
          'Generic', // VideoGamesProduct13 - Accessories
      '682b00a46977bd89257c0e8d':
          'Generic', // VideoGamesProduct14 - Accessories
    };

    final filteredProducts = apiProducts
        .where((product) => detailPages.containsKey(product.id))
        .map((apiProduct) {
      final imagePath =
          'assets/videogames_products/Accessories/accessories${detailPages.keys.toList().indexOf(apiProduct.id) + 1}/1.png';

      final assignedBrand = productBrands[apiProduct.id] ?? 'Generic';

      // Debug logging
      print(
          'Video Game Accessories - Product ID: ${apiProduct.id}, Assigned Brand: $assignedBrand');

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
    print('Video Game Accessories - Final brands in products: $finalBrands');

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
          categoryName: 'Accessories',
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
