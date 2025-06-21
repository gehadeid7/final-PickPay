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

  // Simple category to brands mapping
  static final Map<String, List<String>> categoryBrands = {
    'Electronics': [
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
    'Appliances': [
      'Koldair',
      'Fresh',
      'Midea',
      'Zanussi',
      'Black & Decker',
      'Panasonic',
      'Tornado',
      'deime',
    ],
    'Beauty': [
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
    'Home': [
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
    'VideoGames': [
      'Likorlove',
      'fanxiang',
      'Mcbazel',
      'PlayStation',
      'Nintendo',
    ],
    'Fashion': [],
  };

  // Simple category mapping
  String? _getCategoryKey(String? categoryName) {
    if (categoryName == null) return null;

    final normalized = categoryName.toLowerCase().trim();

    if (normalized.contains('electronics') ||
        normalized.contains('mobile') ||
        normalized.contains('tv') ||
        normalized.contains('laptop')) {
      return 'Electronics';
    }
    if (normalized.contains('appliance')) {
      return 'Appliances';
    }
    if (normalized.contains('beauty') ||
        normalized.contains('fragrance') ||
        normalized.contains('makeup') ||
        normalized.contains('hair') ||
        normalized.contains('skin')) {
      return 'Beauty';
    }
    if (normalized.contains('home') ||
        normalized.contains('furniture') ||
        normalized.contains('bath') ||
        normalized.contains('kitchen')) {
      return 'Home';
    }
    if (normalized.contains('video') ||
        normalized.contains('game') ||
        normalized.contains('console')) {
      return 'VideoGames';
    }
    if (normalized.contains('fashion')) {
      return 'Fashion';
    }

    return null;
  }

  List<String> _getRelevantBrands() {
    // Get brands from actual products in the current view (excluding Generic)
    final productBrands = products
        .map((p) => p.brand)
        .where(
            (brand) => brand != null && brand.isNotEmpty && brand != 'Generic')
        .map((brand) => brand!)
        .toSet();

    // Convert to list and sort
    final sortedBrands = productBrands.toList()..sort();

    // Debug logging
    print('BrandFilterWidget - Total products: ${products.length}');
    print('BrandFilterWidget - Available brands: $sortedBrands');
    print('BrandFilterWidget - Selected brand: $selectedBrand');

    return sortedBrands;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

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
            items: allBrands.map((String brand) {
              return DropdownMenuItem<String>(
                value: brand,
                child: Text(
                  brand,
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
              print('BrandFilterWidget - onChanged called with: $newValue');
              final finalValue = newValue == 'All Brands' ? null : newValue;
              print(
                  'BrandFilterWidget - Final value being passed: $finalValue');
              onBrandChanged(finalValue);
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
