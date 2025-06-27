import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/widgets/base_category_view.dart';
import 'package:pickpay/features/categories_pages/products_views/product_detail_view.dart';
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
import 'package:pickpay/services/api_service.dart';

class ElectronicsViewBody extends StatefulWidget {
  const ElectronicsViewBody({super.key});

  @override
  State<ElectronicsViewBody> createState() => _ElectronicsViewBodyState();
}

class _ElectronicsViewBodyState extends State<ElectronicsViewBody> {
  late Future<List<ProductsViewsModel>> _productsFuture;

  static final Map<String, Widget> detailPages = {
    '6819e22b123a4faad16613be': const Product1View(),
    '6819e22b123a4faad16613bf': const Product2View(),
    '6819e22b123a4faad16613c0': const Product3View(),
    '6819e22b123a4faad16613c1': const Product4View(),
    '6819e22b123a4faad16613c3': const Product5View(),
    '6819e22b123a4faad16613c4': const Product6View(),
    '6819e22b123a4faad16613c5': const Product7View(),
    '6819e22b123a4faad16613c6': const Product8View(),
    '6819e22b123a4faad16613c7': const Product9View(),
    '6819e22b123a4faad16613c8': const Product10View(),
    '6819e22b123a4faad16613c9': const Product11View(),
    '6819e22b123a4faad16613ca': const Product12View(),
    '6819e22b123a4faad16613cb': const Product13View(),
    '6819e22b123a4faad16613cc': const Product14View(),
    '6819e22b123a4faad16613cd': const Product15View(),
  };

  static final Map<String, int> productImageNumbers = {
    '6819e22b123a4faad16613be': 1,
    '6819e22b123a4faad16613bf': 2,
    '6819e22b123a4faad16613c0': 3,
    '6819e22b123a4faad16613c1': 4,
    '6819e22b123a4faad16613c3': 5,
    '6819e22b123a4faad16613c4': 6,
    '6819e22b123a4faad16613c5': 7,
    '6819e22b123a4faad16613c6': 8,
    '6819e22b123a4faad16613c7': 9,
    '6819e22b123a4faad16613c8': 10,
    '6819e22b123a4faad16613c9': 11,
    '6819e22b123a4faad16613ca': 12,
    '6819e22b123a4faad16613cb': 13,
    '6819e22b123a4faad16613cc': 14,
    '6819e22b123a4faad16613cd': 15,
  };

  @override
  void initState() {
    super.initState();
    _productsFuture = _loadProducts();
  }

  Future<List<ProductsViewsModel>> _loadProducts() async {
    final apiProducts = await ApiService().loadProducts();

    final Map<String, String> productBrands = {
      '6819e22b123a4faad16613be': 'SAMSUNG',
      '6819e22b123a4faad16613bf': 'Xiaomi',
      '6819e22b123a4faad16613c0': 'Xiaomi',
      '6819e22b123a4faad16613c1': 'CANSHN',
      '6819e22b123a4faad16613c3': 'Oraimo',
      '6819e22b123a4faad16613c4': 'SAMSUNG',
      '6819e22b123a4faad16613c5': 'SAMSUNG',
      '6819e22b123a4faad16613c6': 'SAMSUNG',
      '6819e22b123a4faad16613c7': 'SAMSUNG',
      '6819e22b123a4faad16613c8': 'LG',
      '6819e22b123a4faad16613c9': 'Lenovo',
      '6819e22b123a4faad16613ca': 'Lenovo',
      '6819e22b123a4faad16613cb': 'HP',
      '6819e22b123a4faad16613cc': 'HP',
      '6819e22b123a4faad16613cd': 'Generic',
    };

    return apiProducts
        .map((apiProduct) {
          final productId = apiProduct.id;
          final imageNumber = productImageNumbers[productId] ?? 0;
          String imagePath;

          if (imageNumber >= 1 && imageNumber <= 5) {
            imagePath = 'assets/electronics_products/mobile_and_tablet/mobile_and_tablet$imageNumber/1.png';
          } else if (imageNumber >= 6 && imageNumber <= 10) {
            imagePath = 'assets/electronics_products/tvscreens/tv${imageNumber - 5}/1.png';
          } else {
            imagePath = 'assets/electronics_products/Laptop/Laptop${imageNumber - 10}/1.png';
          }

          return ProductsViewsModel(
            id: apiProduct.id,
            title: apiProduct.name,
            price: apiProduct.price,
            originalPrice: apiProduct.originalPrice,
            rating: apiProduct.rating,
            reviewCount: apiProduct.reviewCount,
            brand: productBrands[productId] ?? 'Generic',
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
                  'Error: \${snapshot.error}',
                  style: const TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => setState(() => _productsFuture = _loadProducts()),
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(
            child: Text(
              'No electronics available at the moment.',
              style: TextStyle(fontSize: 16),
            ),
          );
        }

        return BaseCategoryView(
          categoryName: 'Electronics',
          products: snapshot.data!,
          productDetailBuilder: (productId) {
            final product = snapshot.data!.firstWhere(
              (p) => p.id == productId,
              orElse: () => ProductsViewsModel(
                id: '',
                title: 'Unknown Product',
                price: 0,
                originalPrice: 0,
                imagePaths: [],
                rating: 0.0,
                reviewCount: 0,
              ),
            );

            if (product.id.isNotEmpty) {
              return ProductDetailView(product: product);
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
