import 'package:flutter/material.dart';
import 'package:pickpay/core/utils/app_text_styles.dart';

class CartHeader extends StatelessWidget {
  const CartHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      width: double.infinity,
      decoration:
          const BoxDecoration(color: Color.fromARGB(255, 235, 235, 235)),
      child: Center(
        child: Text('You have 3 items',
            style: TextStyles.semiBold16.copyWith(
              color: const Color.fromARGB(255, 33, 149, 243),
            )),
      ),
    );
  }
}
