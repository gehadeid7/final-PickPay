import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class InActiveItem extends StatelessWidget {
  const InActiveItem({
    super.key,
    required this.image,
    required this.text,
  });

  final String image;
  final String text;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 24,
          height: 24,
          child: Center(
            child: image.endsWith('.svg')
                ? SvgPicture.asset(
                    image,
                    width: 22,
                    height: 22,
                    colorFilter: ColorFilter.mode(
                      theme.unselectedWidgetColor
                          .withAlpha((0.8 * 255).round()),
                      BlendMode.srcIn,
                    ),
                  )
                : Image.asset(
                    image,
                    width: 22,
                    height: 22,
                    color: theme.unselectedWidgetColor.withAlpha(204),
                  ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          text,
          style: theme.textTheme.labelSmall?.copyWith(
            color: theme.unselectedWidgetColor.withAlpha(204),
            fontSize: 10,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
