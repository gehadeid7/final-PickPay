import 'package:flutter/material.dart';
import 'package:pickpay/core/utils/app_text_styles.dart';

class ActiveItem extends StatelessWidget {
  const ActiveItem({
    super.key,
    required this.text,
    required this.image,
  });

  final String text;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        constraints: const BoxConstraints(
          minWidth: 80, // Minimum width to prevent overflow
          maxWidth: 120, // Maximum width to prevent too wide items
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 4,
        ),
        decoration: ShapeDecoration(
          color: const Color(0xFFDFDFDF), // Using hex color
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 30,
              height: 30,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: Center(
                child: _buildImageWithErrorHandling(),
              ),
            ),
            const SizedBox(width: 4),
            Flexible(
              // Prevents text overflow
              child: Text(
                text,
                style: TextStyles.semiBold13.copyWith(
                  color: Colors.black,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageWithErrorHandling() {
    return Image.asset(
      image,
      width: 25,
      height: 25,
      errorBuilder: (context, error, stackTrace) => Icon(
        Icons.person_outline, // Fallback icon
        size: 25,
        color: Colors.grey,
      ),
    );
  }
}
