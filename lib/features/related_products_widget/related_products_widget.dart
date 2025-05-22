import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/widgets/product_card.dart';
import 'package:pickpay/features/related_products_widget/services/product_service.dart';
import 'package:pickpay/features/categories_pages/products_views/product_detail_view.dart';

// Electronics Products (15)
import 'package:pickpay/features/categories_pages/products_views/electronics_products_views/product1.dart';
import 'package:pickpay/features/categories_pages/products_views/electronics_products_views/product2.dart';
import 'package:pickpay/features/categories_pages/products_views/electronics_products_views/product3.dart';
import 'package:pickpay/features/categories_pages/products_views/electronics_products_views/product4.dart';
import 'package:pickpay/features/categories_pages/products_views/electronics_products_views/product5.dart';
import 'package:pickpay/features/categories_pages/products_views/electronics_products_views/product6.dart';
import 'package:pickpay/features/categories_pages/products_views/electronics_products_views/product7.dart';
import 'package:pickpay/features/categories_pages/products_views/electronics_products_views/product8.dart';
import 'package:pickpay/features/categories_pages/products_views/electronics_products_views/product9.dart';
import 'package:pickpay/features/categories_pages/products_views/electronics_products_views/product10.dart';
import 'package:pickpay/features/categories_pages/products_views/electronics_products_views/product11.dart';
import 'package:pickpay/features/categories_pages/products_views/electronics_products_views/product12.dart';
import 'package:pickpay/features/categories_pages/products_views/electronics_products_views/product13.dart';
import 'package:pickpay/features/categories_pages/products_views/electronics_products_views/product14.dart';
import 'package:pickpay/features/categories_pages/products_views/electronics_products_views/product15.dart';

// Home Products (20)
import 'package:pickpay/features/categories_pages/products_views/home_products/home_product1.dart';
import 'package:pickpay/features/categories_pages/products_views/home_products/home_product2.dart';
import 'package:pickpay/features/categories_pages/products_views/home_products/home_product3.dart';
import 'package:pickpay/features/categories_pages/products_views/home_products/home_product4.dart';
import 'package:pickpay/features/categories_pages/products_views/home_products/home_product5.dart';
import 'package:pickpay/features/categories_pages/products_views/home_products/home_product6.dart';
import 'package:pickpay/features/categories_pages/products_views/home_products/home_product7.dart';
import 'package:pickpay/features/categories_pages/products_views/home_products/home_product8.dart';
import 'package:pickpay/features/categories_pages/products_views/home_products/home_product9.dart';
import 'package:pickpay/features/categories_pages/products_views/home_products/home_product10.dart';
import 'package:pickpay/features/categories_pages/products_views/home_products/home_product11.dart';
import 'package:pickpay/features/categories_pages/products_views/home_products/home_product12.dart';
import 'package:pickpay/features/categories_pages/products_views/home_products/home_product13.dart';
import 'package:pickpay/features/categories_pages/products_views/home_products/home_product14.dart';
import 'package:pickpay/features/categories_pages/products_views/home_products/home_product15.dart';
import 'package:pickpay/features/categories_pages/products_views/home_products/home_product16.dart';
import 'package:pickpay/features/categories_pages/products_views/home_products/home_product17.dart';
import 'package:pickpay/features/categories_pages/products_views/home_products/home_product18.dart';
import 'package:pickpay/features/categories_pages/products_views/home_products/home_product19.dart';
import 'package:pickpay/features/categories_pages/products_views/home_products/home_product20.dart';

// Fashion Products (15)
import 'package:pickpay/features/categories_pages/products_views/fashion_products_views/fashion_product1.dart';
import 'package:pickpay/features/categories_pages/products_views/fashion_products_views/fashion_product2.dart';
import 'package:pickpay/features/categories_pages/products_views/fashion_products_views/fashion_product3.dart';
import 'package:pickpay/features/categories_pages/products_views/fashion_products_views/fashion_product4.dart';
import 'package:pickpay/features/categories_pages/products_views/fashion_products_views/fashion_product5.dart';
import 'package:pickpay/features/categories_pages/products_views/fashion_products_views/fashion_product6.dart';
import 'package:pickpay/features/categories_pages/products_views/fashion_products_views/fashion_product7.dart';
import 'package:pickpay/features/categories_pages/products_views/fashion_products_views/fashion_product8.dart';
import 'package:pickpay/features/categories_pages/products_views/fashion_products_views/fashion_product9.dart';
import 'package:pickpay/features/categories_pages/products_views/fashion_products_views/fashion_product10.dart';
import 'package:pickpay/features/categories_pages/products_views/fashion_products_views/fashion_product11.dart';
import 'package:pickpay/features/categories_pages/products_views/fashion_products_views/fashion_product12.dart';
import 'package:pickpay/features/categories_pages/products_views/fashion_products_views/fashion_product13.dart';
import 'package:pickpay/features/categories_pages/products_views/fashion_products_views/fashion_product14.dart';
import 'package:pickpay/features/categories_pages/products_views/fashion_products_views/fashion_product15.dart';

// Beauty Products (20)
import 'package:pickpay/features/categories_pages/products_views/beauty_products_views/beauty_product1.dart';
import 'package:pickpay/features/categories_pages/products_views/beauty_products_views/beauty_product2.dart';
import 'package:pickpay/features/categories_pages/products_views/beauty_products_views/beauty_product3.dart';
import 'package:pickpay/features/categories_pages/products_views/beauty_products_views/beauty_product4.dart';
import 'package:pickpay/features/categories_pages/products_views/beauty_products_views/beauty_product5.dart';
import 'package:pickpay/features/categories_pages/products_views/beauty_products_views/beauty_product6.dart';
import 'package:pickpay/features/categories_pages/products_views/beauty_products_views/beauty_product7.dart';
import 'package:pickpay/features/categories_pages/products_views/beauty_products_views/beauty_product8.dart';
import 'package:pickpay/features/categories_pages/products_views/beauty_products_views/beauty_product9.dart';
import 'package:pickpay/features/categories_pages/products_views/beauty_products_views/beauty_product10.dart';
import 'package:pickpay/features/categories_pages/products_views/beauty_products_views/beauty_product11.dart';
import 'package:pickpay/features/categories_pages/products_views/beauty_products_views/beauty_product12.dart';
import 'package:pickpay/features/categories_pages/products_views/beauty_products_views/beauty_product13.dart';
import 'package:pickpay/features/categories_pages/products_views/beauty_products_views/beauty_product14.dart';
import 'package:pickpay/features/categories_pages/products_views/beauty_products_views/beauty_product15.dart';
import 'package:pickpay/features/categories_pages/products_views/beauty_products_views/beauty_product16.dart';
import 'package:pickpay/features/categories_pages/products_views/beauty_products_views/beauty_product17.dart';
import 'package:pickpay/features/categories_pages/products_views/beauty_products_views/beauty_product18.dart';
import 'package:pickpay/features/categories_pages/products_views/beauty_products_views/beauty_product19.dart';
import 'package:pickpay/features/categories_pages/products_views/beauty_products_views/beauty_product20.dart';

// Appliances Products (15)
import 'package:pickpay/features/categories_pages/products_views/appliances_products_views/appliances_product1.dart';
import 'package:pickpay/features/categories_pages/products_views/appliances_products_views/appliances_product2.dart';
import 'package:pickpay/features/categories_pages/products_views/appliances_products_views/appliances_product3.dart';
import 'package:pickpay/features/categories_pages/products_views/appliances_products_views/appliances_product4.dart';
import 'package:pickpay/features/categories_pages/products_views/appliances_products_views/appliances_product5.dart';
import 'package:pickpay/features/categories_pages/products_views/appliances_products_views/appliances_product6.dart';
import 'package:pickpay/features/categories_pages/products_views/appliances_products_views/appliances_product7.dart';
import 'package:pickpay/features/categories_pages/products_views/appliances_products_views/appliances_product8.dart';
import 'package:pickpay/features/categories_pages/products_views/appliances_products_views/appliances_product9.dart';
import 'package:pickpay/features/categories_pages/products_views/appliances_products_views/appliances_product10.dart';
import 'package:pickpay/features/categories_pages/products_views/appliances_products_views/appliances_product11.dart';
import 'package:pickpay/features/categories_pages/products_views/appliances_products_views/appliances_product12.dart';
import 'package:pickpay/features/categories_pages/products_views/appliances_products_views/appliances_product13.dart';
import 'package:pickpay/features/categories_pages/products_views/appliances_products_views/appliances_product14.dart';
import 'package:pickpay/features/categories_pages/products_views/appliances_products_views/appliances_product15.dart';

// Video Games Products (14)
import 'package:pickpay/features/categories_pages/products_views/video_games/video_games_product1.dart';
import 'package:pickpay/features/categories_pages/products_views/video_games/video_games_product2.dart';
import 'package:pickpay/features/categories_pages/products_views/video_games/video_games_product3.dart';
import 'package:pickpay/features/categories_pages/products_views/video_games/video_games_product4.dart';
import 'package:pickpay/features/categories_pages/products_views/video_games/video_games_product5.dart';
import 'package:pickpay/features/categories_pages/products_views/video_games/video_games_product6.dart';
import 'package:pickpay/features/categories_pages/products_views/video_games/video_games_product7.dart';
import 'package:pickpay/features/categories_pages/products_views/video_games/video_games_product8.dart';
import 'package:pickpay/features/categories_pages/products_views/video_games/video_games_product9.dart';
import 'package:pickpay/features/categories_pages/products_views/video_games/video_games_product10.dart';
import 'package:pickpay/features/categories_pages/products_views/video_games/video_games_product11.dart';
import 'package:pickpay/features/categories_pages/products_views/video_games/video_games_product12.dart';
import 'package:pickpay/features/categories_pages/products_views/video_games/video_games_product13.dart';
import 'package:pickpay/features/categories_pages/products_views/video_games/video_games_product14.dart';

class RelatedProductsWidget extends StatelessWidget {
  final ProductsViewsModel currentProduct;

  const RelatedProductsWidget({
    super.key,
    required this.currentProduct,
  });

  String _getCategoryDisplayName(String category) {
    switch (category.toLowerCase()) {
      case 'electronics':
        return 'Electronics';
      case 'fashion':
        return 'Fashion';
      case 'beauty':
        return 'Beauty';
      case 'home':
        return 'Home';
      case 'appliances':
        return 'Appliances';
      case 'video_games':
        return 'Video Games';
      default:
        return 'Other';
    }
  }

  Widget? _getProductDetailView(String productId) {
    // Electronics products (15)
    if (productId.startsWith('elec')) {
      switch (productId) {
        case 'elec1':
          return const Product1View();
        case 'elec2':
          return const Product2View();
        case 'elec3':
          return const Product3View();
        case 'elec4':
          return const Product4View();
        case 'elec5':
          return const Product5View();
        case 'elec6':
          return const Product6View();
        case 'elec7':
          return const Product7View();
        case 'elec8':
          return const Product8View();
        case 'elec9':
          return const Product9View();
        case 'elec10':
          return const Product10View();
        case 'elec11':
          return const Product11View();
        case 'elec12':
          return const Product12View();
        case 'elec13':
          return const Product13View();
        case 'elec14':
          return const Product14View();
        case 'elec15':
          return const Product15View();
      }
    }

    // Home products (20)
    if (productId.startsWith('home')) {
      switch (productId) {
        case 'home1':
          return const HomeProduct1();
        case 'home2':
          return const HomeProduct2();
        case 'home3':
          return const HomeProduct3();
        case 'home4':
          return const HomeProduct4();
        case 'home5':
          return const HomeProduct5();
        case 'home6':
          return const HomeProduct6();
        case 'home7':
          return const HomeProduct7();
        case 'home8':
          return const HomeProduct8();
        case 'home9':
          return const HomeProduct9();
        case 'home10':
          return const HomeProduct10();
        case 'home11':
          return const HomeProduct11();
        case 'home12':
          return const HomeProduct12();
        case 'home13':
          return const HomeProduct13();
        case 'home14':
          return const HomeProduct14();
        case 'home15':
          return const HomeProduct15();
        case 'home16':
          return const HomeProduct16();
        case 'home17':
          return const HomeProduct17();
        case 'home18':
          return const HomeProduct18();
        case 'home19':
          return const HomeProduct19();
        case 'home20':
          return const HomeProduct20();
      }
    }

    // Fashion products (15)
    if (productId.startsWith('fashion_')) {
      switch (productId) {
        case 'fashion_1':
          return const FashionProduct1();
        case 'fashion_2':
          return const FashionProduct2();
        case 'fashion_3':
          return const FashionProduct3();
        case 'fashion_4':
          return const FashionProduct4();
        case 'fashion_5':
          return const FashionProduct5();
        case 'fashion_6':
          return const FashionProduct6();
        case 'fashion_7':
          return const FashionProduct7();
        case 'fashion_8':
          return const FashionProduct8();
        case 'fashion_9':
          return const FashionProduct9();
        case 'fashion_10':
          return const FashionProduct10();
        case 'fashion_11':
          return const FashionProduct11();
        case 'fashion_12':
          return const FashionProduct12();
        case 'fashion_13':
          return const FashionProduct13();
        case 'fashion_14':
          return const FashionProduct14();
        case 'fashion_15':
          return const FashionProduct15();
      }
    }

    // Beauty products (20)
    if (productId.startsWith('68132a95ff7813b3d47f9da')) {
      final num = int.tryParse(productId.substring(productId.length - 2)) ?? 0;
      switch (num) {
        case 1:
          return const BeautyProduct1();
        case 2:
          return const BeautyProduct2();
        case 3:
          return const BeautyProduct3();
        case 4:
          return const BeautyProduct4();
        case 5:
          return const BeautyProduct5();
        case 6:
          return const BeautyProduct6();
        case 7:
          return const BeautyProduct7();
        case 8:
          return const BeautyProduct8();
        case 9:
          return const BeautyProduct9();
        case 10:
          return const BeautyProduct10();
        case 11:
          return const BeautyProduct11();
        case 12:
          return const BeautyProduct12();
        case 13:
          return const BeautyProduct13();
        case 14:
          return const BeautyProduct14();
        case 15:
          return const BeautyProduct15();
        case 16:
          return const BeautyProduct16();
        case 17:
          return const BeautyProduct17();
        case 18:
          return const BeautyProduct18();
        case 19:
          return const BeautyProduct19();
        case 20:
          return const BeautyProduct20();
      }
    }

    // Appliances products (15)
    if (productId.startsWith('appliances_')) {
      switch (productId) {
        case 'appliances_1':
          return const AppliancesProduct1();
        case 'appliances_2':
          return const AppliancesProduct2();
        case 'appliances_3':
          return const AppliancesProduct3();
        case 'appliances_4':
          return const AppliancesProduct4();
        case 'appliances_5':
          return const AppliancesProduct5();
        case 'appliances_6':
          return const AppliancesProduct6();
        case 'appliances_7':
          return const AppliancesProduct7();
        case 'appliances_8':
          return const AppliancesProduct8();
        case 'appliances_9':
          return const AppliancesProduct9();
        case 'appliances_10':
          return const AppliancesProduct10();
        case 'appliances_11':
          return const AppliancesProduct11();
        case 'appliances_12':
          return const AppliancesProduct12();
        case 'appliances_13':
          return const AppliancesProduct13();
        case 'appliances_14':
          return const AppliancesProduct14();
        case 'appliances_15':
          return const AppliancesProduct15();
      }
    }

    // Video Games products (14)
    if (productId.startsWith('games_')) {
      switch (productId) {
        case 'games_1':
          return const VideoGamesProduct1();
        case 'games_2':
          return const VideoGamesProduct2();
        case 'games_3':
          return const VideoGamesProduct3();
        case 'games_4':
          return const VideoGamesProduct4();
        case 'games_5':
          return const VideoGamesProduct5();
        case 'games_6':
          return const VideoGamesProduct6();
        case 'games_7':
          return const VideoGamesProduct7();
        case 'games_8':
          return const VideoGamesProduct8();
        case 'games_9':
          return const VideoGamesProduct9();
        case 'games_10':
          return const VideoGamesProduct10();
        case 'games_11':
          return const VideoGamesProduct11();
        case 'games_12':
          return const VideoGamesProduct12();
        case 'games_13':
          return const VideoGamesProduct13();
        case 'games_14':
          return const VideoGamesProduct14();
      }
    }

    // Return null for unknown product IDs to fallback to generic view
    return null;
  }

  void _navigateToProduct(BuildContext context, ProductsViewsModel product) {
    // Try to get a specific product view first
    final specificView = _getProductDetailView(product.id);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            specificView ?? ProductDetailView(product: product),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    final productService = ProductService.instance;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'You May Also Like',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: isDarkMode ? Colors.white : Colors.black,
            ),
          ),
        ),
        FutureBuilder<List<ProductsViewsModel>>(
          future: productService.getRelatedProducts(currentProduct.id),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return SizedBox(
                height: 380,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Theme.of(context).primaryColor,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Finding products you might like...',
                        style: TextStyle(
                          color:
                              isDarkMode ? Colors.grey[400] : Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }

            if (snapshot.hasError) {
              return Container(
                height: 380,
                padding: const EdgeInsets.all(16.0),
                margin: const EdgeInsets.symmetric(horizontal: 16.0),
                decoration: BoxDecoration(
                  color: isDarkMode ? Colors.grey[850] : Colors.grey[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error_outline,
                      color: Theme.of(context).colorScheme.error,
                      size: 32,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Error loading recommendations',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.error,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Please try again later',
                      style: TextStyle(
                        color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              );
            }

            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Container(
                height: 380,
                padding: const EdgeInsets.all(16.0),
                margin: const EdgeInsets.symmetric(horizontal: 16.0),
                decoration: BoxDecoration(
                  color: isDarkMode ? Colors.grey[850] : Colors.grey[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.info_outline,
                      color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
                      size: 32,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'No recommendations found',
                      style: TextStyle(
                        color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Try browsing our categories for more products',
                      style: TextStyle(
                        color: isDarkMode ? Colors.grey[500] : Colors.grey[700],
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              );
            }

            final relatedProducts = snapshot.data!;

            // Group products by category
            final productsByCategory = <String, List<ProductsViewsModel>>{};
            for (final product in relatedProducts) {
              final category = productService.getCategoryFromId(product.id);
              productsByCategory.putIfAbsent(category, () => []).add(product);
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (final category in productsByCategory.keys)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
                        child: Text(
                          _getCategoryDisplayName(category),
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: isDarkMode
                                ? Colors.grey[300]
                                : Colors.grey[700],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 280,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          itemCount: productsByCategory[category]!.length,
                          itemBuilder: (context, index) {
                            final product =
                                productsByCategory[category]![index];
                            return Container(
                              width: 180,
                              margin: const EdgeInsets.only(right: 12),
                              child: ProductCard(
                                id: product.id,
                                name: product.title,
                                imagePaths: product.imagePaths ?? [],
                                price: product.price,
                                originalPrice: product.originalPrice ?? 0,
                                rating: product.rating ?? 0,
                                reviewCount: product.reviewCount ?? 0,
                                onTap: () =>
                                    _navigateToProduct(context, product),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
              ],
            );
          },
        ),
      ],
    );
  }
}
