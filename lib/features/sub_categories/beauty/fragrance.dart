import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/widgets/base_category_view.dart';
import 'package:pickpay/features/categories_pages/products_views/beauty_products_views/beauty_product16.dart';
import 'package:pickpay/features/categories_pages/products_views/beauty_products_views/beauty_product17.dart';
import 'package:pickpay/features/categories_pages/products_views/beauty_products_views/beauty_product18.dart';
import 'package:pickpay/features/categories_pages/products_views/beauty_products_views/beauty_product19.dart';
import 'package:pickpay/features/categories_pages/products_views/beauty_products_views/beauty_product20.dart';
import 'package:pickpay/services/api_service.dart';

class Fragrance extends StatefulWidget {
  const Fragrance({super.key});

  @override
  State<Fragrance> createState() => _FragranceState();
}

class _FragranceState extends State<Fragrance> {
  late Future<List<ProductsViewsModel>> _productsFuture;

  // Map of product detail pages
  static final Map<String, Widget> detailPages = {
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

    // Define actual brands for Fragrance products
    final Map<String, String> productBrands = {
      '682b00d16977bd89257c0e8e': 'L\'Oréal Paris', // BeautyProduct1
      '682b00d16977bd89257c0e8f': 'L\'Oréal Paris', // BeautyProduct2
      '682b00d16977bd89257c0e90': 'Cybele', // BeautyProduct3
      '682b00d16977bd89257c0e91': 'Eva', // BeautyProduct4
      '682b00d16977bd89257c0e92': 'MAYBELLINE', // BeautyProduct5
    };

    return apiProducts
        .where((apiProduct) => detailPages.containsKey(apiProduct.id))
        .map((apiProduct) {
      final productIndex = detailPages.keys.toList().indexOf(apiProduct.id) + 1;
      final imagePath = 'assets/beauty_products/fragrance_$productIndex/1.png';

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
          categoryName: 'Fragrance',
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
