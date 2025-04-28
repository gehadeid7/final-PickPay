import 'package:flutter/material.dart';
import 'package:pickpay/core/utils/app_colors.dart';
import 'package:pickpay/core/utils/app_text_styles.dart';
import 'package:pickpay/features/categories_pages/fashion/presentation/views/fashion_view.dart';

class FashionHeader extends StatelessWidget {
  const FashionHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: GestureDetector(
        onTap: () => Navigator.pushNamed(context, FashionView.routeName),
        child: Row(
          children: [
            Text(
              'Fashion',
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
      ),
    );
  }
}
