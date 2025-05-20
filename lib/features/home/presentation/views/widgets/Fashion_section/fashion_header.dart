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
      child: Column(
        children: [
          Row(
            children: [
              Text('Fashion Bestsellers',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  )),
              Spacer(),
              GestureDetector(
                onTap: () =>
                    Navigator.pushNamed(context, FashionView.routeName),
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
