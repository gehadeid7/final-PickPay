import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/widgets/base_category_view.dart';
import 'package:pickpay/services/api_service.dart';

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

class HomeCategoryViewBody extends StatefulWidget {
  const HomeCategoryViewBody({super.key});

  @override
  State<HomeCategoryViewBody> createState() => _HomeCategoryViewBodyState();
}

class _HomeCategoryViewBodyState extends State<HomeCategoryViewBody> {
  late Future<List<ProductsViewsModel>> _productsFuture;

  static final Map<String, Widget> detailPages = {
    '681dab0df9c9147444b452cd': const HomeProduct1(),
    '681dab0df9c9147444b452ce': const HomeProduct2(),
    '681dab0df9c9147444b452cf': const HomeProduct3(),
    '681dab0df9c9147444b452d0': const HomeProduct4(),
    '681dab0df9c9147444b452d1': const HomeProduct5(),
    '681dab0df9c9147444b452d2': const HomeProduct6(),
    '681dab0df9c9147444b452d3': const HomeProduct7(),
    '681dab0df9c9147444b452d4': const HomeProduct8(),
    '681dab0df9c9147444b452d5': const HomeProduct9(),
    '681dab0df9c9147444b452d6': const HomeProduct10(),
    '681dab0df9c9147444b452d7': const HomeProduct11(),
    '681dab0df9c9147444b452d8': const HomeProduct12(),
    '681dab0df9c9147444b452d9': const HomeProduct13(),
    '681dab0df9c9147444b452da': const HomeProduct14(),
    '681dab0df9c9147444b452db': const HomeProduct15(),
    '681dab0df9c9147444b452dc': const HomeProduct16(),
    '681dab0df9c9147444b452dd': const HomeProduct17(),
    '681dab0df9c9147444b452de': const HomeProduct18(),
    '681dab0df9c9147444b452df': const HomeProduct19(),
    '681dab0df9c9147444b452e0': const HomeProduct20(),
  };

  @override
  void initState() {
    super.initState();
    _productsFuture = _loadProducts();
  }

  Future<List<ProductsViewsModel>> _loadProducts() async {
    final apiProducts = await ApiService().loadProducts();

    final Map<String, String> productBrands = {
      '681dab0df9c9147444b452cd': 'Generic',
      '681dab0df9c9147444b452ce': 'Generic',
      '681dab0df9c9147444b452cf': 'Generic',
      '681dab0df9c9147444b452d0': 'Generic',
      '681dab0df9c9147444b452d1': 'Generic',
      '681dab0df9c9147444b452d2': 'Golden Lighting',
      '681dab0df9c9147444b452d3': 'Generic',
      '681dab0df9c9147444b452d4': 'Generic',
      '681dab0df9c9147444b452d5': 'Generic',
      '681dab0df9c9147444b452d6': 'Generic',
      '681dab0df9c9147444b452d7': 'Neoflam',
      '681dab0df9c9147444b452d8': 'Pasabahce',
      '681dab0df9c9147444b452d9': 'Generic',
      '681dab0df9c9147444b452da': 'Generic',
      '681dab0df9c9147444b452db': 'Generic',
      '681dab0df9c9147444b452dc': 'Banotex',
      '681dab0df9c9147444b452dd': 'Generic',
      '681dab0df9c9147444b452de': 'Generic',
      '681dab0df9c9147444b452df': 'Generic',
      '681dab0df9c9147444b452e0': 'Generic',
    };

    final Map<String, String> productImagePaths = {
      '681dab0df9c9147444b452cd': 'assets/Home_products/furniture/furniture1/1.png',
      '681dab0df9c9147444b452ce': 'assets/Home_products/furniture/furniture2/1.png',
      '681dab0df9c9147444b452cf': 'assets/Home_products/furniture/furniture3/1.png',
      '681dab0df9c9147444b452d0': 'assets/Home_products/furniture/furniture4/1.png',
      '681dab0df9c9147444b452d1': 'assets/Home_products/furniture/furniture5/1.png',
      '681dab0df9c9147444b452d2': 'assets/Home_products/home-decor/home_decor1/1.png',
      '681dab0df9c9147444b452d3': 'assets/Home_products/home-decor/home_decor2/1.png',
      '681dab0df9c9147444b452d4': 'assets/Home_products/home-decor/home_decor3/1.png',
      '681dab0df9c9147444b452d5': 'assets/Home_products/home-decor/home_decor4/1.png',
      '681dab0df9c9147444b452d6': 'assets/Home_products/home-decor/home_decor5/1.png',
      '681dab0df9c9147444b452d7': 'assets/Home_products/kitchen/kitchen1/1.png',
      '681dab0df9c9147444b452d8': 'assets/Home_products/kitchen/kitchen2/1.png',
      '681dab0df9c9147444b452d9': 'assets/Home_products/kitchen/kitchen3/1.png',
      '681dab0df9c9147444b452da': 'assets/Home_products/kitchen/kitchen4/1.png',
      '681dab0df9c9147444b452db': 'assets/Home_products/kitchen/kitchen5/1.png',
      '681dab0df9c9147444b452dc': 'assets/Home_products/bath_and_bedding/bath1/1.png',
      '681dab0df9c9147444b452dd': 'assets/Home_products/bath_and_bedding/bath2/1.png',
      '681dab0df9c9147444b452de': 'assets/Home_products/bath_and_bedding/bath3/1.png',
      '681dab0df9c9147444b452df': 'assets/Home_products/bath_and_bedding/bath4/1.png',
      '681dab0df9c9147444b452e0': 'assets/Home_products/bath_and_bedding/bath5/1.png',
    };

    return apiProducts
        .where((apiProduct) => detailPages.containsKey(apiProduct.id))
        .map((apiProduct) => ProductsViewsModel(
              id: apiProduct.id,
              title: apiProduct.name,
              price: apiProduct.price,
              originalPrice: apiProduct.originalPrice,
              rating: apiProduct.rating ?? 4.5,
              reviewCount: apiProduct.reviewCount ?? 100,
              brand: productBrands[apiProduct.id] ?? 'Generic',
              imagePaths: [productImagePaths[apiProduct.id] ?? ''],
              soldBy: 'PickPay',
              isPickPayFulfilled: true,
            ))
        .toList();
  }

  Widget? _findDetailPageById(String productId) => detailPages[productId];

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ProductsViewsModel>>(
      future: _productsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
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
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(
            child: Text('No home products available at the moment.', style: TextStyle(fontSize: 16)),
          );
        }

        return BaseCategoryView(
          categoryName: 'Home',
          products: snapshot.data!,
          productDetailBuilder: (productId) => _findDetailPageById(productId) ??
              Scaffold(
                appBar: AppBar(title: const Text('Product Not Found')),
                body: const Center(child: Text('Product details not available')),
              ),
        );
      },
    );
  }
}