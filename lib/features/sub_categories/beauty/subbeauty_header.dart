import 'package:flutter/material.dart';
import 'package:pickpay/core/utils/app_text_styles.dart';

class SubbeautyHeader extends StatelessWidget {
  const SubbeautyHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: [
          Center(
            child: Text(
              'Beauty',
              style: TextStyles.bold19,
            ),
          ),
          const SizedBox(height: 6),
          Container(
            height: 1.5,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(4),
              ),
              gradient: LinearGradient(
                colors: [
                  const Color.fromARGB(255, 32, 140, 229),
                  Colors.lightBlueAccent,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
