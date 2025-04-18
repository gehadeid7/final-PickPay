import 'package:flutter/material.dart';
import 'package:pickpay/core/utils/app_colors.dart';
import 'package:pickpay/core/utils/app_text_styles.dart';

class RecommendedForuHeader extends StatelessWidget {
  const RecommendedForuHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: Row(
        children: [
          Text(
            'Recommended For You',
            style: TextStyles.bold16,
          ),
          Spacer(),
          Text(
            'more',
            style: TextStyles.regular16.copyWith(
              color: AppColors.secondColor,
            ),
          )
        ],
      ),
    );
  }
}
