import 'package:flutter/material.dart';
import 'package:pickpay/core/utils/app_images.dart';
import 'package:pickpay/core/utils/app_text_styles.dart';

class SearchTextField extends StatelessWidget {
  const SearchTextField({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return TextField(
      keyboardType: TextInputType.text,
      style: TextStyles.regular16.copyWith(
        color: Theme.of(context).textTheme.bodyLarge?.color,
      ),
      decoration: InputDecoration(
        isCollapsed: true,
        contentPadding: const EdgeInsets.symmetric(vertical: 8),
        hintStyle: TextStyles.regular16.copyWith(
          color: isDarkMode ? Colors.grey[400] : const Color(0xFF949D9E),
        ),
        hintText: 'Search...',
        filled: true,
        fillColor: isDarkMode ? Colors.grey[800] : Colors.grey.shade100,
        prefixIcon: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(
            Assets.search,
            width: 20,
            height: 20,
            fit: BoxFit.contain,
            color: isDarkMode ? Colors.grey[400] : null,
          ),
        ),
        prefixIconConstraints: const BoxConstraints(
          minWidth: 40,
          minHeight: 40,
        ),
        border: _buildBorder(context, isDarkMode),
        enabledBorder: _buildBorder(context, isDarkMode),
        focusedBorder: _buildBorder(context, isDarkMode, isFocused: true),
      ),
    );
  }

  OutlineInputBorder _buildBorder(BuildContext context, bool isDarkMode,
      {bool isFocused = false}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(18),
      borderSide: BorderSide(
        width: 1,
        color: isFocused
            ? Theme.of(context).colorScheme.primary
            : isDarkMode
                ? Colors.grey[700]!
                : Colors.grey.shade400,
      ),
    );
  }
}
