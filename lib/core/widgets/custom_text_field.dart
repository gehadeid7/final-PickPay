import 'package:flutter/material.dart';
import 'package:pickpay/core/utils/app_text_styles.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.hintText,
    required this.textInputType,  this.suffixicon,
  });
  final String hintText;
  final TextInputType textInputType;
  final Widget? suffixicon; 

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: textInputType,
      decoration: InputDecoration(
        suffixIcon: suffixicon,
        hintText: hintText,
        hintStyle: TextStyles.bold13.copyWith(color: Colors.grey),
        filled: true,
        fillColor: const Color(0xFFF9FAFA),
        border: buildBorder(const Color(0xFFE6E9E9)),
        enabledBorder: buildBorder(const Color(0xFFE6E9E9)),
        focusedBorder: buildBorder(Colors.blueAccent),
      ),
    );
  }

  OutlineInputBorder buildBorder(Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(4),
      borderSide: BorderSide(width: 1, color: color),
    );
  }
}
