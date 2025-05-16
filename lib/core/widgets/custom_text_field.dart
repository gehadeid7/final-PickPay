import 'package:flutter/material.dart';
import 'package:pickpay/core/utils/app_text_styles.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.hintText,
    required this.textInputType,
    this.suffixicon,
    this.onSaved,
    this.obsecureText = false,
    this.validator,
  });

  final String hintText;
  final TextInputType textInputType;
  final Widget? suffixicon;
  final void Function(String?)? onSaved;
  final bool obsecureText;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return TextFormField(
      obscureText: obsecureText,
      onSaved: onSaved,
      validator: validator ??
          (value) {
            if (value == null || value.isEmpty) {
              return 'This field is required';
            }
            return null;
          },
      keyboardType: textInputType,
      style: TextStyle(color: theme.colorScheme.onSurface),
      decoration: InputDecoration(
        suffixIcon: suffixicon,
        hintText: hintText,
        hintStyle: TextStyles.bold13.copyWith(
          color: isDarkMode
              // ignore: deprecated_member_use
              ? theme.colorScheme.onSurface.withOpacity(0.5)
              : Colors.grey,
        ),
        filled: true,
        fillColor: isDarkMode
            // ignore: deprecated_member_use
            ? theme.colorScheme.surfaceVariant
            : const Color(0xFFF9FAFA),
        border:
            buildBorder(isDarkMode ? theme.colorScheme.outline : Colors.white),
        enabledBorder: buildBorder(isDarkMode
            ? theme.colorScheme.outline
            : const Color.fromARGB(255, 230, 230, 230)),
        focusedBorder: buildBorder(theme.colorScheme.primary),
        errorBorder: buildBorder(theme.colorScheme.error),
        focusedErrorBorder: buildBorder(theme.colorScheme.error),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
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
