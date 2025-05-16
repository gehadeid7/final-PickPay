import 'package:flutter/material.dart';
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
      width: 140,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
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
                    color: Theme.of(context).dividerColor,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: Theme.of(context).dividerColor,
                  ),
                ),
              ),
              items: allBrands.map((String? brand) {
                return DropdownMenuItem<String>(
                  value: brand,
                  child: Text(brand ?? 'Unknown Brand'),
                );
              }).toList(),
              onChanged: (String? newValue) {
                onBrandChanged(newValue == 'All Brands' ? null : newValue);
              },
              isExpanded: true,
            ),
          ],
        ),
      ),
    );
  }
}
