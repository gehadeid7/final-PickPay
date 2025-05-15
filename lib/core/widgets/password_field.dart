import 'package:flutter/material.dart';
import 'package:pickpay/core/widgets/custom_text_field.dart';

class PasswordField extends StatefulWidget {
  const PasswordField({
    super.key,
    this.onSaved,
    this.validator, // Added validator parameter
  });
  final void Function(String?)? onSaved;
  final String? Function(String?)? validator; // New validator

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool obsecureText = true;

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      obsecureText: obsecureText,
      onSaved: widget.onSaved,
      validator: widget.validator, // Pass validator through
      suffixicon: GestureDetector(
        onTap: () {
          setState(() {
            obsecureText = !obsecureText;
          });
        },
        child: Icon(
          obsecureText ? Icons.visibility_off : Icons.visibility,
          color: Colors.grey,
        ),
      ),
      hintText: 'Enter a valid password',
      textInputType: TextInputType.visiblePassword,
    );
  }
}
