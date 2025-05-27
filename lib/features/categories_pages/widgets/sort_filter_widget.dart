import 'package:flutter/material.dart';

enum SortOption {
  none,
  priceAsc,
  priceDesc,
  ratingDesc,
  ratingAsc,
}

class SortFilterWidget extends StatelessWidget {
  final SortOption selectedOption;
  final ValueChanged<SortOption> onChanged;

  const SortFilterWidget({
    super.key,
    required this.selectedOption,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 8),
          child: Text(
            'Sort By',
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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildSortOption(
                context,
                'Default',
                SortOption.none,
                Icons.swap_vert_rounded,
              ),
              _buildDivider(isDarkMode),
              _buildSortOption(
                context,
                'Price: Low-High',
                SortOption.priceAsc,
                Icons.arrow_upward_rounded,
              ),
              _buildDivider(isDarkMode),
              _buildSortOption(
                context,
                'Price: High-Low',
                SortOption.priceDesc,
                Icons.arrow_downward_rounded,
              ),
              _buildDivider(isDarkMode),
              _buildSortOption(
                context,
                'Rating: High-Low',
                SortOption.ratingDesc,
                Icons.star_rounded,
              ),
              _buildDivider(isDarkMode),
              _buildSortOption(
                context,
                'Rating: Low-High',
                SortOption.ratingAsc,
                Icons.star_outline_rounded,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSortOption(
    BuildContext context,
    String label,
    SortOption option,
    IconData icon,
  ) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    final isSelected = selectedOption == option;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => onChanged(option),
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size: 16,
                color: isSelected
                    ? theme.colorScheme.primary
                    : isDarkMode
                        ? Colors.grey
                        : const Color(0xFF9E9E9E),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                    color: isSelected
                        ? isDarkMode
                            ? Colors.white
                            : const Color(0xFF2C3E50)
                        : isDarkMode
                            ? Colors.grey
                            : const Color(0xFF757575),
                    letterSpacing: -0.2,
                  ),
                ),
              ),
              if (isSelected) ...[
                const SizedBox(width: 4),
                Icon(
                  Icons.check_rounded,
                  size: 16,
                  color: theme.colorScheme.primary,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDivider(bool isDarkMode) {
    return Divider(
      height: 1,
      thickness: 1,
      color: isDarkMode ? Colors.grey.shade800 : const Color(0xFFEEEEEE),
    );
  }
}
