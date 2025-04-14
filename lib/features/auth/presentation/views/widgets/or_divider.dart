import 'package:flutter/material.dart';
import 'package:pickpay/core/utils/app_text_styles.dart';

class OrDivider extends StatelessWidget {
  const OrDivider({super.key});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          child: Divider(color: Color.fromARGB(255, 170, 170, 170)),
        ),
        SizedBox(width: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Text(
            'Or',
            textAlign: TextAlign.center,
            style: TextStyles.semiBold16.copyWith(
              color: const Color.fromARGB(255, 86, 86, 86),
              fontSize: 14,
            ),
          ),
        ),
        SizedBox(width: 16),
        const Expanded(
          child: Divider(color: Color.fromARGB(255, 170, 170, 170)),
        ),
      ],
    );
  }
}
