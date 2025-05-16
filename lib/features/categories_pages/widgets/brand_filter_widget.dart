import 'package:flutter/material.dart';
import 'package:pickpay/core/utils/app_text_styles.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';

class BrandFilterWidget extends StatelessWidget {
  final List<ProductsViewsModel> products;
  final String? selectedBrand;
  final ValueChanged<String?> onBrandChanged;

  const BrandFilterWidget({
    super.key,
    required this.products,
    required this.selectedBrand,
    required this.onBrandChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    // Extract unique brands from products
    final brands = products
        .map((p) => p.brand)
        .where((brand) => brand != null && brand.isNotEmpty)
        .toSet()
        .toList()
      ..sort((a, b) => a!.compareTo(b!));

    // Add "All Brands" option at the beginning
    final allBrands = ['All Brands', ...?brands];

    return SizedBox(
      child: Container(
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isDarkMode ? Colors.grey.shade700 : Colors.grey.shade200,
          ),
          boxShadow: [
            BoxShadow(
              // ignore: deprecated_member_use
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButtonFormField<String>(
              value: selectedBrand ?? 'All Brands',
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: isDarkMode
                        ? Colors.grey.shade700
                        : Colors.grey.shade200,
                    width: 1.5,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: isDarkMode
                        ? Colors.grey.shade700
                        : Colors.grey.shade200,
                    width: 1.5,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: theme.colorScheme.primary,
                    width: 1.5,
                  ),
                ),
              ),
              items: allBrands.map((String? brand) {
                return DropdownMenuItem<String>(
                  value: brand,
                  child:
                      Text(brand ?? 'Unknown Brand', style: TextStyles.bold16),
                );
              }).toList(),
              onChanged: (String? newValue) {
                onBrandChanged(newValue == 'All Brands' ? null : newValue);
              },
              isExpanded: true,
              dropdownColor: theme.cardColor,
              style: theme.textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
