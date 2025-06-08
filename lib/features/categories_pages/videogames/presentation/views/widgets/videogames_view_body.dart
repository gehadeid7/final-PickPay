import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';

import 'package:pickpay/features/categories_pages/products_views/video_games/video_games_product1.dart';
import 'package:pickpay/features/categories_pages/products_views/video_games/video_games_product10.dart';
import 'package:pickpay/features/categories_pages/products_views/video_games/video_games_product11.dart';
import 'package:pickpay/features/categories_pages/products_views/video_games/video_games_product12.dart';
import 'package:pickpay/features/categories_pages/products_views/video_games/video_games_product13.dart';
import 'package:pickpay/features/categories_pages/products_views/video_games/video_games_product14.dart';
import 'package:pickpay/features/categories_pages/products_views/video_games/video_games_product2.dart';
import 'package:pickpay/features/categories_pages/products_views/video_games/video_games_product3.dart';
import 'package:pickpay/features/categories_pages/products_views/video_games/video_games_product4.dart';
import 'package:pickpay/features/categories_pages/products_views/video_games/video_games_product5.dart';
import 'package:pickpay/features/categories_pages/products_views/video_games/video_games_product6.dart';
import 'package:pickpay/features/categories_pages/products_views/video_games/video_games_product7.dart';
import 'package:pickpay/features/categories_pages/products_views/video_games/video_games_product8.dart';
import 'package:pickpay/features/categories_pages/products_views/video_games/video_games_product9.dart';
import 'package:pickpay/features/categories_pages/widgets/base_category_view.dart';
import 'package:pickpay/services/api_service.dart';

class VideogamesViewBody extends StatefulWidget {
  const VideogamesViewBody({super.key});

  @override
  State<VideogamesViewBody> createState() =>
      _VideogamesViewBodyState();
}

class _VideogamesViewBodyState extends State<VideogamesViewBody> {
  late Future<List<ProductsViewsModel>> _productsFuture;

  static final Map<String, Widget> detailPages = {
    '682b00a46977bd89257c0e80': const VideoGamesProduct1(),
    '682b00a46977bd89257c0e81': const VideoGamesProduct2(),
    '682b00a46977bd89257c0e82': const VideoGamesProduct3(),
    '682b00a46977bd89257c0e83': const VideoGamesProduct4(),
    '682b00a46977bd89257c0e84': const VideoGamesProduct5(),
    '682b00a46977bd89257c0e85': const VideoGamesProduct6(),
    '682b00a46977bd89257c0e86': const VideoGamesProduct7(),
    '682b00a46977bd89257c0e87': const VideoGamesProduct8(),
    '682b00a46977bd89257c0e88': const VideoGamesProduct9(),
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

    return apiProducts
        .map((apiProduct) {
          final productIndex =
              detailPages.keys.toList().indexOf(apiProduct.id) + 1;
          final imagePath =
              'assets/fashion_products/fashion$productIndex/1.png';

          return ProductsViewsModel(
            id: apiProduct.id,
            title: apiProduct.name,
            price: apiProduct.price,
            originalPrice: apiProduct.originalPrice,
            rating: apiProduct.rating ?? 4.5,
            reviewCount: apiProduct.reviewCount ?? 100,
            imagePaths: [imagePath],
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
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, color: Colors.red, size: 60),
                const SizedBox(height: 16),
                Text(
                  'Error: ${snapshot.error}',
                  style: const TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () =>
                      setState(() => _productsFuture = _loadProducts()),
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(
            child: Text(
              'No Video Games products available at the moment.',
              style: TextStyle(fontSize: 16),
            ),
          );
        }

        return BaseCategoryView(
          categoryName: 'Fashion',
          products: snapshot.data!,
          productDetailBuilder: (productId) {
            final detailPage = _findDetailPageById(productId);
            if (detailPage != null) {
              return detailPage;
            }
            return Scaffold(
              appBar: AppBar(title: const Text('Product Not Found')),
              body: const Center(child: Text('Product details not available')),
            );
          },
        );
      },
    );
  }
}
