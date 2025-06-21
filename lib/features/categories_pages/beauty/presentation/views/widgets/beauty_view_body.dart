import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/products_views/beauty_products_views/beauty_product1.dart';
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
import 'package:pickpay/features/categories_pages/products_views/beauty_products_views/beauty_product2.dart';
import 'package:pickpay/features/categories_pages/products_views/beauty_products_views/beauty_product20.dart';
import 'package:pickpay/features/categories_pages/products_views/beauty_products_views/beauty_product3.dart';
import 'package:pickpay/features/categories_pages/products_views/beauty_products_views/beauty_product4.dart';
import 'package:pickpay/features/categories_pages/products_views/beauty_products_views/beauty_product5.dart';
import 'package:pickpay/features/categories_pages/products_views/beauty_products_views/beauty_product6.dart';
import 'package:pickpay/features/categories_pages/products_views/beauty_products_views/beauty_product7.dart';
import 'package:pickpay/features/categories_pages/products_views/beauty_products_views/beauty_product8.dart';
import 'package:pickpay/features/categories_pages/products_views/beauty_products_views/beauty_product9.dart';

import 'package:pickpay/features/categories_pages/widgets/base_category_view.dart';
import 'package:pickpay/services/api_service.dart';

class BeautyViewBody extends StatefulWidget {
  const BeautyViewBody({super.key});

  @override
  State<BeautyViewBody> createState() => _BeautyViewBodyState();
}

class _BeautyViewBodyState extends State<BeautyViewBody> {
  late Future<List<ProductsViewsModel>> _productsFuture;

  static final Map<String, Widget> detailPages = {
    '682b00d16977bd89257c0e9d': const BeautyProduct1(),
    '682b00d16977bd89257c0e9e': const BeautyProduct2(),
    '682b00d16977bd89257c0e9f': const BeautyProduct3(),
    '682b00d16977bd89257c0ea0': const BeautyProduct4(),
    '682b00d16977bd89257c0ea1': const BeautyProduct5(),
    '682b00d16977bd89257c0ea2': const BeautyProduct6(),
    '682b00d16977bd89257c0ea3': const BeautyProduct7(),
    '682b00d16977bd89257c0ea4': const BeautyProduct8(),
    '682b00d16977bd89257c0ea5': const BeautyProduct9(),
    '682b00d16977bd89257c0ea6': const BeautyProduct10(),
    '682b00d16977bd89257c0ea7': const BeautyProduct11(),
    '682b00d16977bd89257c0ea8': const BeautyProduct12(),
    '682b00d16977bd89257c0ea9': const BeautyProduct13(),
    '682b00d16977bd89257c0eaa': const BeautyProduct14(),
    '682b00d16977bd89257c0eab': const BeautyProduct15(),
    '682b00d16977bd89257c0eac': const BeautyProduct16(),
    '682b00d16977bd89257c0ead': const BeautyProduct17(),
    '682b00d16977bd89257c0eae': const BeautyProduct18(),
    '682b00d16977bd89257c0eaf': const BeautyProduct19(),
    '682b00d16977bd89257c0eb0': const BeautyProduct20(),
  };

  @override
  void initState() {
    super.initState();
    _productsFuture = _loadProducts();
  }

  Future<List<ProductsViewsModel>> _loadProducts() async {
    final apiProducts = await ApiService().loadProducts();


    // Map product ID to image path
    final Map<String, String> productImagePaths = {
      '682b00d16977bd89257c0e9d': 'assets/beauty_products/makeup_1/1.png',
      '682b00d16977bd89257c0e9e': 'assets/beauty_products/makeup_2/1.png',
      '682b00d16977bd89257c0e9f': 'assets/beauty_products/makeup_3/1.png',
      '682b00d16977bd89257c0ea0': 'assets/beauty_products/makeup_4/1.png',
      '682b00d16977bd89257c0ea1': 'assets/beauty_products/makeup_5/1.png',
      '682b00d16977bd89257c0ea2': 'assets/beauty_products/skincare_1/1.png',
      '682b00d16977bd89257c0ea3': 'assets/beauty_products/skincare_2/1.png',
      '682b00d16977bd89257c0ea4': 'assets/beauty_products/skincare_3/1.png',
      '682b00d16977bd89257c0ea5': 'assets/beauty_products/skincare_4/1.png',
      '682b00d16977bd89257c0ea6': 'assets/beauty_products/skincare_5/1.png',
      '682b00d16977bd89257c0ea7': 'assets/beauty_products/haircare_1/1.png',
      '682b00d16977bd89257c0ea8': 'assets/beauty_products/haircare_2/1.png',
      '682b00d16977bd89257c0ea9': 'assets/beauty_products/haircare_3/1.png',
      '682b00d16977bd89257c0eaa': 'assets/beauty_products/haircare_4/1.png',
      '682b00d16977bd89257c0eab': 'assets/beauty_products/haircare_5/1.png',
      '682b00d16977bd89257c0eac': 'assets/beauty_products/fragrance_1/1.png',
      '682b00d16977bd89257c0ead': 'assets/beauty_products/fragrance_2/1.png',
      '682b00d16977bd89257c0eae': 'assets/beauty_products/fragrance_3/1.png',
      '682b00d16977bd89257c0eaf': 'assets/beauty_products/fragrance_4/1.png',
      '682b00d16977bd89257c0eb0': 'assets/beauty_products/fragrance_5/1.png',
    };

    return apiProducts
        .where((apiProduct) => detailPages.containsKey(apiProduct.id))
        .map((apiProduct) {
      final imagePath = productImagePaths[apiProduct.id] ?? '';

      return ProductsViewsModel(
        id: apiProduct.id,
        title: apiProduct.name,
        price: apiProduct.price,
        originalPrice: apiProduct.originalPrice,
        rating: apiProduct.rating ?? 4.5,
        reviewCount: apiProduct.reviewCount ?? 100,
        imagePaths: [imagePath],
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
              'No beauty products available at the moment.',
              style: TextStyle(fontSize: 16),
            ),
          );
        }

        return BaseCategoryView(
          categoryName: 'Beauty',
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
