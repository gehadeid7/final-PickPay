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
      child: Column(
        children: [
          Row(
            children: [
              Text('Beauty & Fragrance Bestsellers',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  )),
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
          const SizedBox(height: 6),
          Container(
            height: 1,
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
