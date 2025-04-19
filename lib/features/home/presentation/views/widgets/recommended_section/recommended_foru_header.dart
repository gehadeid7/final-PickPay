import 'package:flutter/material.dart';
import 'package:pickpay/core/utils/app_text_styles.dart';

class RecommendedForuHeader extends StatelessWidget {
  const RecommendedForuHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Text(
        'Recommended For You',
        style: TextStyles.bold16,
      ),
    );
  }
}
