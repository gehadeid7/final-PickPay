import 'package:flutter/material.dart';
import 'package:pickpay/core/utils/app_colors.dart';
import 'package:pickpay/core/utils/app_text_styles.dart';
import 'package:pickpay/features/categories_pages/videogames/presentation/views/videogames_view.dart';

class VigamesSectionHeader extends StatelessWidget {
  const VigamesSectionHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: [
          Text(
            'Video Games Bestsellers',
            style: TextStyles.bold16,
          ),
          const Spacer(),
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, VideogamesView.routeName),
            child: Text(
              'more',
              style: TextStyles.regular16.copyWith(
                color: AppColors.secondColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
