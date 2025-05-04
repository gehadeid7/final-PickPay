import 'package:flutter/material.dart';
import 'package:pickpay/core/utils/app_colors.dart';
import 'package:pickpay/core/utils/app_text_styles.dart';
import 'package:pickpay/features/categories_pages/appliances/presentation/views/appliances_view.dart';

class AppliancesHeader extends StatelessWidget {
  const AppliancesHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: [
          Text(
            'Appliances Bestsellers',
            style: TextStyles.bold16,
          ),
          Spacer(),
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, AppliancesView.routeName),
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
