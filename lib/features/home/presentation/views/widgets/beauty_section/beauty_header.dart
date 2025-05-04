import 'package:flutter/material.dart';
import 'package:pickpay/core/utils/app_colors.dart' show AppColors;
import 'package:pickpay/core/utils/app_text_styles.dart';
import 'package:pickpay/features/categories_pages/beauty/presentation/views/beauty_view.dart';

class BeautyHeader extends StatelessWidget {
  const BeautyHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: [
          Text(
            'Beauty & Fragrance Bestsellers',
            style: TextStyles.bold16,
          ),
          Spacer(),
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, BeautyView.routeName),
            child: Text(
              'more',
              style: TextStyles.regular16.copyWith(
                color: AppColors.secondColor,
              ),
            ),
          )
        ],
      ),
    );
  }
}
