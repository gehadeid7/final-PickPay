import 'package:flutter/material.dart';

class DealsFilterWidget extends StatelessWidget {
  final String? selectedDealType;
  final ValueChanged<String?> onDealTypeChanged;

  const DealsFilterWidget({
    super.key,
    required this.selectedDealType,
    required this.onDealTypeChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    final dealOptions = ['All', 'Fresh Sale'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 8),
          child: Text(
            'Deals',
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
            value: selectedDealType ?? 'All',
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
            items: dealOptions.map<DropdownMenuItem<String>>((String option) {
              return DropdownMenuItem<String>(
                value: option,
                child: Text(
                  option,
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
              onDealTypeChanged(newValue == 'All' ? null : newValue);
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
