import 'package:flutter/material.dart';
import 'package:pickpay/core/utils/app_images.dart';

class CustomCheckbox extends StatelessWidget {
  const CustomCheckbox({
    super.key,
    required this.isChecked,
    required this.onChecked,
  });

  final bool isChecked;
  final ValueChanged<bool> onChecked;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return GestureDetector(
      onTap: () => onChecked(!isChecked),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        width: 24,
        height: 24,
        decoration: BoxDecoration(
          color: isChecked ? colorScheme.primary : colorScheme.surface,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            width: 1.5,
            color: isChecked
                ? Colors.transparent
                // ignore: deprecated_member_use
                : colorScheme.outline.withOpacity(0.5),
          ),
        ),
        child: isChecked
            ? Padding(
                padding: const EdgeInsets.all(3.0),
                child: Image.asset(
                  Assets.checkIcon,
                  color: colorScheme.onPrimary,
                ),
              )
            : const SizedBox(),
      ),
    );
  }
}
