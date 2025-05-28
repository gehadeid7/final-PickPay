import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';

import 'package:pickpay/features/categories_pages/products_views/fashion_products_views/fashion_product1.dart';
import 'package:pickpay/features/categories_pages/products_views/fashion_products_views/fashion_product10.dart';
import 'package:pickpay/features/categories_pages/products_views/fashion_products_views/fashion_product11.dart';
import 'package:pickpay/features/categories_pages/products_views/fashion_products_views/fashion_product12.dart';
import 'package:pickpay/features/categories_pages/products_views/fashion_products_views/fashion_product13.dart';
import 'package:pickpay/features/categories_pages/products_views/fashion_products_views/fashion_product14.dart';
import 'package:pickpay/features/categories_pages/products_views/fashion_products_views/fashion_product15.dart';
import 'package:pickpay/features/categories_pages/products_views/fashion_products_views/fashion_product2.dart';
import 'package:pickpay/features/categories_pages/products_views/fashion_products_views/fashion_product3.dart';
import 'package:pickpay/features/categories_pages/products_views/fashion_products_views/fashion_product4.dart';
import 'package:pickpay/features/categories_pages/products_views/fashion_products_views/fashion_product5.dart';
import 'package:pickpay/features/categories_pages/products_views/fashion_products_views/fashion_product6.dart';
import 'package:pickpay/features/categories_pages/products_views/fashion_products_views/fashion_product7.dart';
import 'package:pickpay/features/categories_pages/products_views/fashion_products_views/fashion_product8.dart';
import 'package:pickpay/features/categories_pages/products_views/fashion_products_views/fashion_product9.dart';
import 'package:pickpay/features/categories_pages/widgets/base_category_view.dart';
import 'package:pickpay/services/api_service.dart';

class FashionCategoryViewBody extends StatefulWidget {
  const FashionCategoryViewBody({super.key});

  @override
  State<FashionCategoryViewBody> createState() =>
      _FashionCategoryViewBodyState();
}

class _FashionCategoryViewBodyState extends State<FashionCategoryViewBody> {
  late Future<List<ProductsViewsModel>> _productsFuture;

  static final Map<String, Widget> detailPages = {
    '682b00c26977bd89257c0e8e': const FashionProduct1(),
    '682b00c26977bd89257c0e8f': const FashionProduct2(),
    '682b00c26977bd89257c0e90': const FashionProduct3(),
    '682b00c26977bd89257c0e91': const FashionProduct4(),
    '682b00c26977bd89257c0e92': const FashionProduct5(),
    '682b00c26977bd89257c0e93': const FashionProduct6(),
    '682b00c26977bd89257c0e94': const FashionProduct7(),
    '682b00c26977bd89257c0e95': const FashionProduct8(),
    '682b00c26977bd89257c0e96': const FashionProduct9(),
    '682b00c26977bd89257c0e97': const FashionProduct10(),
    '682b00c26977bd89257c0e98': const FashionProduct11(),
    '682b00c26977bd89257c0e99': const FashionProduct12(),
    '682b00c26977bd89257c0e9a': const FashionProduct13(),
    '682b00c26977bd89257c0e9b': const FashionProduct14(),
    '682b00c26977bd89257c0e9c': const FashionProduct15(),
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
              'No fashion products available at the moment.',
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
