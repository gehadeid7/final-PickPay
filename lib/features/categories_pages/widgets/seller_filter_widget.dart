import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';

class SellerFilterWidget extends StatelessWidget {
  final List<ProductsViewsModel> products;
  final String? selectedSeller;
  final ValueChanged<String?> onSellerChanged;

  const SellerFilterWidget({
    super.key,
    required this.products,
    required this.selectedSeller,
    required this.onSellerChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    final sellers = products
        .map((p) => p.soldBy)
        .where((seller) => seller != null && seller.isNotEmpty)
        .toSet()
        .toList()
      ..sort();

    final allSellers = ['All Sellers', ...sellers.whereType<String>()];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 8),
          child: Text(
            'Seller',
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
            value: selectedSeller ?? 'All Sellers',
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
            items: allSellers.map<DropdownMenuItem<String>>((String seller) {
              return DropdownMenuItem<String>(
                value: seller,
                child: Text(
                  seller,
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
              onSellerChanged(newValue == 'All Sellers' ? null : newValue);
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
