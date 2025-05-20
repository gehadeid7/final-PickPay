// in_active_item.dart
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class InActiveItem extends StatelessWidget {
  const InActiveItem({
    super.key,
    required this.image,
    required this.text,
    this.itemCount,
  });

  final String image;
  final String text;
  final int? itemCount;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
          clipBehavior: Clip.none,
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
            if (itemCount != null && itemCount! > 0)
              Positioned(
                top: -4,
                right: -4,
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  constraints: const BoxConstraints(
                    minWidth: 16,
                    minHeight: 16,
                  ),
                  child: Text(
                    itemCount!.toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 8,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
          ],
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
