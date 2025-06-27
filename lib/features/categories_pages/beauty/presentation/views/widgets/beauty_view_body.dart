import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/widgets/base_category_view.dart';
import 'package:pickpay/features/categories_pages/products_views/product_detail_view.dart';
import 'package:pickpay/services/api_service.dart';

class BeautyViewBody extends StatefulWidget {
  const BeautyViewBody({super.key});

  @override
  State<BeautyViewBody> createState() => _BeautyViewBodyState();
}

class _BeautyViewBodyState extends State<BeautyViewBody> {
  late Future<List<ProductsViewsModel>> _productsFuture;

  @override
  void initState() {
    super.initState();
    _productsFuture = _loadProducts();
  }

  Future<List<ProductsViewsModel>> _loadProducts() async {
    final apiProducts = await ApiService().loadProducts();

    // Define actual brands for Beauty products
    final Map<String, String> productBrands = {
      '682b00d16977bd89257c0e9d': 'L\'Oréal Paris',
      '682b00d16977bd89257c0e9e': 'L\'Oréal Paris',
      '682b00d16977bd89257c0e9f': 'Cybele',
      '682b00d16977bd89257c0ea0': 'Eva',
      '682b00d16977bd89257c0ea1': 'MAYBELLINE',
      '682b00d16977bd89257c0ea2': 'La Roche-Posay',
      '682b00d16977bd89257c0ea3': 'Eucerin',
      '682b00d16977bd89257c0ea4': 'Care & More',
      '682b00d16977bd89257c0ea5': 'NIVEA',
      '682b00d16977bd89257c0ea6': 'Garnier',
      '682b00d16977bd89257c0ea7': 'L\'Oréal Paris',
      '682b00d16977bd89257c0ea8': 'Garnier',
      '682b00d16977bd89257c0ea9': 'NIVEA',
      '682b00d16977bd89257c0eaa': 'Raw African',
      '682b00d16977bd89257c0eab': 'Gulf Orchid',
      '682b00d16977bd89257c0eac': 'Avon',
      '682b00d16977bd89257c0ead': 'Gulf Orchid',
      '682b00d16977bd89257c0eae': '9Street Corner',
      '682b00d16977bd89257c0eaf': 'NIVEA',
      '682b00d16977bd89257c0eb0': 'Jacques Bogart',
    };

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

    final filteredProducts = apiProducts
        .where((apiProduct) => productImagePaths.containsKey(apiProduct.id))
        .map((apiProduct) {
      final imagePath = productImagePaths[apiProduct.id] ?? '';
      final assignedBrand = productBrands[apiProduct.id] ?? 'Generic';

      return ProductsViewsModel(
        id: apiProduct.id,
        title: apiProduct.name,
        price: apiProduct.price,
        originalPrice: apiProduct.originalPrice,
        rating: apiProduct.rating ?? 4.5,
        reviewCount: apiProduct.reviewCount ?? 100,
        brand: assignedBrand,
        imagePaths: [imagePath],
        soldBy: 'PickPay',
        isPickPayFulfilled: true,
      );
    }).toList();

    return filteredProducts;
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
