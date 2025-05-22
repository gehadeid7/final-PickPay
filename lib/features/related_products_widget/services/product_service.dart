import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/related_products_widget/data/product_data.dart';

class ProductService {
  // Singleton pattern
  static final ProductService _instance = ProductService._internal();
  static ProductService get instance => _instance;
  factory ProductService() => _instance;
  ProductService._internal();

  // Categories mapping
  static const Map<String, List<String>> categoryMapping = {
    'electronics': ['mobile_and_tablet', 'tvs', 'laptop'],
    'fashion': ['women_fashion', 'men_fashion', 'kids_fashion'],
    'beauty': ['makeup', 'skincare', 'haircare', 'fragrance'],
    'home': ['furniture', 'home_decor', 'kitchen', 'bath_and_bedding'],
    'appliances': ['large_appliances', 'small_appliances'],
    'video_games': ['console', 'controllers', 'accessories'],
  };

  // Get subcategory from product ID
  String getSubCategoryFromId(String id) {
    if (id.startsWith('elec')) {
      final num = int.tryParse(id.substring(4)) ?? 0;
      if (num >= 1 && num <= 5) return 'mobile_and_tablet';
      if (num >= 6 && num <= 10) return 'tvs';
      return 'laptop';
    }

    if (id.startsWith('fashion_')) {
      if (id.contains('women_')) return 'women_fashion';
      if (id.contains('men_')) return 'men_fashion';
      if (id.contains('kids_')) return 'kids_fashion';
    }

    if (id.startsWith('68132a95ff7813b3d47f9da')) {
      final num = int.tryParse(id.substring(id.length - 2)) ?? 0;
      if (num >= 1 && num <= 5) return 'makeup';
      if (num >= 6 && num <= 10) return 'skincare';
      if (num >= 11 && num <= 15) return 'haircare';
      if (num >= 16 && num <= 20) return 'fragrance';
    }

    if (id.startsWith('home_')) {
      if (id.contains('furniture_')) return 'furniture';
      if (id.contains('decor_')) return 'home_decor';
      if (id.contains('kitchen_')) return 'kitchen';
      if (id.contains('bath_')) return 'bath_and_bedding';
    }

    if (id.startsWith('appliances_')) {
      if (id.contains('large_')) return 'large_appliances';
      if (id.contains('small_')) return 'small_appliances';
    }

    if (id.startsWith('games_')) {
      if (id.contains('console_')) return 'console';
      if (id.contains('controller_')) return 'controllers';
      if (id.contains('acc_')) return 'accessories';
    }

    return 'unknown';
  }

  String getCategoryFromId(String id) {
    if (id.startsWith('elec')) return 'electronics';
    if (id.startsWith('fashion_')) return 'fashion';
    if (id.startsWith('68132a95ff7813b3d47f9da')) return 'beauty';
    if (id.startsWith('home_')) return 'home';
    if (id.startsWith('appliances_')) return 'appliances';
    if (id.startsWith('games_')) return 'video_games';
    return 'unknown';
  }

  // Get related products from all categories
  Future<List<ProductsViewsModel>> getRelatedProducts(String productId) async {
    final currentCategory = getCategoryFromId(productId);
    final currentSubcategory = getSubCategoryFromId(productId);

    // Get all products from all categories
    final allProducts = await _getAllProductsFromAllCategories();

    // Remove the current product
    allProducts.removeWhere((product) => product.id == productId);

    // Filter to only get products from the same category
    final sameCategoryProducts = allProducts
        .where((product) => getCategoryFromId(product.id) == currentCategory)
        .toList();

    // Sort products by relevance:
    // 1. Same subcategory (most relevant - show up to 5)
    // 2. Other subcategories in same category (show up to 3)

    // Get products from same subcategory
    final sameSubcategoryProducts = sameCategoryProducts
        .where(
            (product) => getSubCategoryFromId(product.id) == currentSubcategory)
        .toList();

    // Get products from other subcategories in same category
    final otherSubcategoryProducts = sameCategoryProducts
        .where(
            (product) => getSubCategoryFromId(product.id) != currentSubcategory)
        .toList();

    // Shuffle each list for variety
    sameSubcategoryProducts.shuffle();
    otherSubcategoryProducts.shuffle();

    // Combine the lists with priority
    List<ProductsViewsModel> result = [];

    // Add up to 5 products from same subcategory
    result.addAll(sameSubcategoryProducts.take(5));

    // Add up to 3 products from other subcategories in same category
    result.addAll(otherSubcategoryProducts.take(3));

    return result;
  }

  // Get all products from all categories
  Future<List<ProductsViewsModel>> _getAllProductsFromAllCategories() async {
    // Simulate network delay for realism
    await Future.delayed(const Duration(milliseconds: 300));

    List<ProductsViewsModel> allProducts = [];

    // Get products from each category
    allProducts.addAll(ProductData.getElectronicsProducts());
    allProducts.addAll(ProductData.getFashionProducts());
    allProducts.addAll(ProductData.getBeautyProducts());
    allProducts.addAll(ProductData.getHomeProducts());
    allProducts.addAll(ProductData.getAppliancesProducts());
    allProducts.addAll(ProductData.getVideoGamesProducts());

    return allProducts;
  }

  // Get products by category (kept for backward compatibility)
  Future<List<ProductsViewsModel>> getProductsByCategory(String category,
      {String? productId}) async {
    if (productId != null) {
      return getRelatedProducts(productId);
    }

    // If no productId provided, return all products from the category
    switch (category.toLowerCase()) {
      case 'electronics':
        return ProductData.getElectronicsProducts();
      case 'fashion':
        return ProductData.getFashionProducts();
      case 'beauty':
        return ProductData.getBeautyProducts();
      case 'home':
        return ProductData.getHomeProducts();
      case 'appliances':
        return ProductData.getAppliancesProducts();
      case 'video_games':
        return ProductData.getVideoGamesProducts();
      default:
        return [];
    }
  }
}
