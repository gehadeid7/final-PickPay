import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';

class BrandFilterWidget extends StatelessWidget {
  final List<ProductsViewsModel> products;
  final String? selectedBrand;
  final ValueChanged<String?> onBrandChanged;
  final String? currentCategory;

  const BrandFilterWidget({
    super.key,
    required this.products,
    required this.selectedBrand,
    required this.onBrandChanged,
    this.currentCategory,
  });

  // Static brand lists organized by category
  static const Map<String, List<String>> categoryBrands = {
    'Electronics': <String>[
      'SAMSUNG',
      'LG',
      'Xiaomi',
      'Lenovo',
      'HP',
      'Sharp',
      'Oraimo',
      'CANSHN',
      'Generic',
    ],
    'Appliances': <String>[
      'Koldair',
      'Fresh',
      'Midea',
      'Zanussi',
      'Black & Decker',
      'Panasonic',
      'Tornado',
      'deime',
    ],
    'Beauty': <String>[
      'L\'Oréal Paris',
      'MAYBELLINE',
      'La Roche-Posay',
      'Care & More',
      'Eucerin',
      'Cybele',
      'Eva',
      '9Street Corner',
      'NIVEA',
      'Gulf Orchid',
      'Garnier',
      'Raw African',
      'CORATED',
      'Jacques Bogart',
      'Avon',
    ],
    'Home': <String>[
      'oliruim',
      'Pasabahce',
      'P&P CHEF',
      'S2C',
      'LIANYU',
      'Banotex',
      'Bedsure',
      'Neoflam',
      'Home of Linen',
      'Furgle',
      'Janssen',
      'Golden Lighting',
      'Amotpo',
      'Generic',
    ],
    'VideoGames': <String>[
      'Likorlove',
      'fanxiang',
      'Mcbazel',
      'PlayStation',
      'Nintendo',
    ],
    'Fashion': <String>[
      // Fashion products don't have brands in the current data
      // Add any fashion brands if they exist in the future
    ],
  };

  // Helper method to map specific category names to brand categories
  String? _mapCategoryToBrandCategory(String? categoryName) {
    if (categoryName == null) return null;

    // Normalize the category name for comparison
    final normalizedCategory = categoryName.toLowerCase().trim();

    // Map specific category names to brand categories
    switch (normalizedCategory) {
      // Electronics and its subcategories
      case 'electronics':
      case 'mobile & tablets':
      case 'mobile and tablets':
      case 'tvs':
      case 'laptops':
      case 'laptop':
        return 'Electronics';

      // Appliances and its subcategories
      case 'appliances':
      case 'large appliances':
      case 'small appliances':
        return 'Appliances';

      // Beauty and its subcategories
      case 'beauty':
      case 'fragrance':
      case 'makeup':
      case 'haircare':
      case 'skincare':
      case 'skin care':
        return 'Beauty';

      // Home and its subcategories
      case 'home':
      case 'furniture':
      case 'bath & bedding':
      case 'bath and bedding':
      case 'home decor':
      case 'home decoration':
      case 'kitchen & dining':
      case 'kitchen and dining':
        return 'Home';

      // Video Games and its subcategories
      case 'video games':
      case 'videogames':
      case 'video games':
      case 'console':
      case 'accessories':
      case 'controllers':
        return 'VideoGames';

      // Fashion and its subcategories
      case 'fashion':
      case 'women\'s fashion':
      case 'womens fashion':
      case 'men\'s fashion':
      case 'mens fashion':
      case 'kids\' fashion':
      case 'kids fashion':
        return 'Fashion';

      default:
        // If no exact match, try partial matching
        if (normalizedCategory.contains('electronics') ||
            normalizedCategory.contains('mobile') ||
            normalizedCategory.contains('tv') ||
            normalizedCategory.contains('laptop')) {
          return 'Electronics';
        }
        if (normalizedCategory.contains('appliance')) {
          return 'Appliances';
        }
        if (normalizedCategory.contains('beauty') ||
            normalizedCategory.contains('fragrance') ||
            normalizedCategory.contains('makeup') ||
            normalizedCategory.contains('hair') ||
            normalizedCategory.contains('skin')) {
          return 'Beauty';
        }
        if (normalizedCategory.contains('home') ||
            normalizedCategory.contains('furniture') ||
            normalizedCategory.contains('bath') ||
            normalizedCategory.contains('kitchen')) {
          return 'Home';
        }
        if (normalizedCategory.contains('video') ||
            normalizedCategory.contains('game') ||
            normalizedCategory.contains('console')) {
          return 'VideoGames';
        }
        if (normalizedCategory.contains('fashion')) {
          return 'Fashion';
        }

        return null;
    }
  }

  // Helper method to get relevant brands based on category and subcategory
  List<String> _getRelevantBrands() {
    if (currentCategory == null) {
      // If no category specified, fall back to dynamic generation from products
      final dynamicBrands = products
          .map((p) => p.brand)
          .where((brand) => brand != null && brand.isNotEmpty)
          .map((brand) => brand!) // Convert String? to String
          .toSet()
          .toList();

      // Create a new modifiable list and sort it
      final sortedBrands = List<String>.from(dynamicBrands);
      sortedBrands.sort();
      return sortedBrands;
    }

    // Map the current category to the appropriate brand category
    final brandCategory = _mapCategoryToBrandCategory(currentCategory);

    // Get brands for the mapped category only (no dynamic product brands)
    final categoryBrandList = brandCategory != null
        ? (categoryBrands[brandCategory] ?? []).cast<String>()
        : <String>[];

    // Create a new modifiable list and sort it
    final sortedBrands = List<String>.from(categoryBrandList);
    sortedBrands.sort();
    return sortedBrands;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    // Get only relevant brands for the current view
    final brands = _getRelevantBrands();
    final allBrands = ['All Brands', ...brands];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 8),
          child: Text(
            'Brand',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: isDarkMode ? Colors.white : const Color(0xFF2C3E50),
              letterSpacing: -0.2,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: isDarkMode ? Colors.grey.shade900 : Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color:
                  isDarkMode ? Colors.grey.shade800 : const Color(0xFFEEEEEE),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF9E9E9E).withOpacity(0.08),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: DropdownButtonFormField<String>(
            value: selectedBrand ?? 'All Brands',
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: theme.colorScheme.primary.withOpacity(0.5),
                  width: 1,
                ),
              ),
              filled: true,
              fillColor: isDarkMode ? Colors.grey.shade900 : Colors.white,
            ),
            items: allBrands.map((String? brand) {
              return DropdownMenuItem<String>(
                value: brand,
                child: Text(
                  brand ?? 'Unknown Brand',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: isDarkMode ? Colors.white : const Color(0xFF2C3E50),
                    letterSpacing: -0.2,
                  ),
                ),
              );
            }).toList(),
            onChanged: (String? newValue) {
              onBrandChanged(newValue == 'All Brands' ? null : newValue);
            },
            icon: Icon(
              Icons.keyboard_arrow_down_rounded,
              color: isDarkMode ? Colors.white70 : const Color(0xFF9E9E9E),
            ),
            isExpanded: true,
            dropdownColor: isDarkMode ? Colors.grey.shade900 : Colors.white,
            style: theme.textTheme.bodyMedium,
          ),
        ),
      ],
    );
  }
}
