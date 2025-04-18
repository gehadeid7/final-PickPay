import 'package:flutter/material.dart';
import 'package:pickpay/core/utils/app_text_styles.dart';

class RecommendedHeader extends StatelessWidget {
  const RecommendedHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
          child: Text(
            'Recommended For You',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w600, // SemiBold
              fontSize: 20, // Just right!
              color: Colors.black87,
              letterSpacing: 0.4, // Crisp spacing
            ),
          ),
        ),
      ],
    );
  }
}
