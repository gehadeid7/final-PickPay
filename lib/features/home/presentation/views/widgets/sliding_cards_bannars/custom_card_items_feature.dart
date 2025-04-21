import 'package:flutter/material.dart';
import 'package:pickpay/core/utils/app_text_styles.dart';

class SlidingFeatureItem extends StatelessWidget {
  final String imagePath;
  final String title;
  final String subtitle;

  const SlidingFeatureItem({
    super.key,
    required this.imagePath,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final itemWidth = MediaQuery.of(context).size.width;

    return SizedBox(
      width: itemWidth,
      child: Stack(
        children: [
          Image.asset(
            imagePath,
            width: itemWidth,
            fit: BoxFit.cover,
          ),
          Positioned(
            bottom: 16,
            left: 16,
            right: 16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyles.bold13.copyWith(
                    color: Colors.white,
                    fontSize: 20,
                    shadows: [
                      const Shadow(
                        blurRadius: 4,
                        color: Colors.black54,
                        offset: Offset(1, 1),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyles.semiBold11.copyWith(
                    color: Colors.white,
                    fontSize: 14,
                    shadows: [
                      const Shadow(
                        blurRadius: 4,
                        color: Colors.black45,
                        offset: Offset(1, 1),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
