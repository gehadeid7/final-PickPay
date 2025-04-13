import 'package:flutter/material.dart';
import 'package:pickpay/core/widgets/custom_text_field.dart';

class PasswordField extends StatefulWidget {
  const PasswordField({
    super.key,
    this.onSaved,
  });
  final void Function(String?)? onSaved;

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
      suffixicon: GestureDetector(
        onTap: () {
          obsecureText = !obsecureText;
          setState(() {});
        },
        child: obsecureText
            ? Icon(Icons.remove_red_eye, color: Colors.grey)
            : Icon(
                Icons.visibility_off,
                color: const Color.fromARGB(255, 89, 89, 89),
              ),
      ),
      hintText: 'Enter a valid password',
      textInputType: TextInputType.visiblePassword,
    );
  }
}
