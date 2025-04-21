import 'package:flutter/material.dart';
import 'package:pickpay/core/utils/app_images.dart';
import 'package:pickpay/core/utils/app_text_styles.dart';

class SearchTextField extends StatelessWidget {
  const SearchTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        isCollapsed: true,
        contentPadding: EdgeInsets.symmetric(vertical: 8),
        hintStyle: TextStyles.regular16.copyWith(
          color: Color(0xFF949D9E),
        ),
        hintText: 'Search...',
        filled: true,
        fillColor: Color(0xFFF9FAFA),
        prefixIcon: Padding(
          padding: EdgeInsets.all(8.0),
          child: Image.asset(
            Assets.search,
            width: 20,
            height: 20,
            fit: BoxFit.contain,
          ),
        ),
        prefixIconConstraints: BoxConstraints(
          minWidth: 40,
          minHeight: 40,
        ),
        border: buildBorder(const Color(0xFFE6E9E9)),
        enabledBorder: buildBorder(const Color(0xFFE6E9E9)),
      ),
    );
  }

  OutlineInputBorder buildBorder(Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(
        width: 1,
        color: Colors.white,
      ),
    );
  }
}
