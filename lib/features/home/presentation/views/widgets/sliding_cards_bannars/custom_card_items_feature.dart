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

    return Container(
      width: itemWidth * 0.97, // almost full width
      margin: const EdgeInsets.symmetric(
          horizontal: 4, vertical: 6), // tiny horizontal margin
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            // ignore: deprecated_member_use
            color: Colors.black.withOpacity(0.25),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
          BoxShadow(
            // ignore: deprecated_member_use
            color: Colors.black.withOpacity(0.10),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Image with subtle parallax-ish effect placeholder (for real parallax, wrap with a custom widget)
            Image.asset(
              imagePath,
              width: itemWidth,
              fit: BoxFit.cover,
              colorBlendMode: BlendMode.darken,
            ),
            // Gradient overlay (darker to transparent)
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    // ignore: deprecated_member_use
                    Colors.black.withOpacity(0.7),
                    Colors.transparent,
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
            ),
            // Text content
            Positioned(
              bottom: 24,
              left: 24,
              right: 24,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyles.bold13.copyWith(
                      color: Colors.white,
                      fontSize: 24,
                      letterSpacing: 1.1,
                      shadows: [
                        Shadow(
                          blurRadius: 8,
                          color: Colors.black87,
                          offset: const Offset(2, 2),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    subtitle,
                    style: TextStyles.semiBold11.copyWith(
                      color: Colors.white70,
                      fontSize: 16,
                      shadows: [
                        Shadow(
                          blurRadius: 6,
                          color: Colors.black54,
                          offset: const Offset(1, 1),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
