import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
    final theme = Theme.of(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            color: theme.primaryColor.withAlpha((0.15 * 255).round()),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: image.endsWith('.svg')
                ? SvgPicture.asset(
                    image,
                    width: 20,
                    height: 20,
                    colorFilter: ColorFilter.mode(
                      theme.primaryColor,
                      BlendMode.srcIn,
                    ),
                  )
                : Image.asset(
                    image,
                    width: 20,
                    height: 20,
                    color: theme.primaryColor,
                  ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          text,
          style: theme.textTheme.labelSmall?.copyWith(
            color: theme.primaryColor,
            fontSize: 12,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
