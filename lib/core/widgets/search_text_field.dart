import 'package:flutter/material.dart';
import 'package:pickpay/core/utils/app_colors.dart';
import 'package:pickpay/core/utils/app_text_styles.dart';

class SearchTextField extends StatelessWidget {
  const SearchTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: Color(0x0A000000),
          blurRadius: 9,
          offset: Offset(0, 2),
          spreadRadius: 0,
        )
      ]),
      child: TextField(
        keyboardType: TextInputType.text,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          hintStyle: TextStyles.regular16.copyWith(
            color: AppColors.secondColor,
          ),
          hintText: 'What are you looking for?',
          filled: true,
          fillColor: Colors.white,
          border: buildBorder(const Color(0xFFE6E9E9)),
          enabledBorder: buildBorder(const Color(0xFFE6E9E9)),
          contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
        ),
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
