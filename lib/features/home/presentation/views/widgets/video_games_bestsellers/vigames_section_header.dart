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
      child: Column(
        children: [
          Row(
            children: [
              Text('Video Games Bestsellers',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  )),
              const Spacer(),
              GestureDetector(
                onTap: () =>
                    Navigator.pushNamed(context, VideogamesView.routeName),
                child: Text(
                  'more',
                  style: TextStyles.regular16.copyWith(
                    color: AppColors.secondColor,
                  ),
                ),
              ),
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
