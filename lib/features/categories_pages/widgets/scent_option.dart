import 'package:flutter/material.dart';

class ScentOption extends StatefulWidget {
  final List<String> scentOption;
  final void Function(String selectedScent)? onScentSelected;
  final bool showLabel;
  final EdgeInsetsGeometry? padding;
  final Color? selectionColor;
  final double selectedBorderWidth;
  final BorderRadius? borderRadius;
  final TextStyle? labelStyle;
  final TextStyle? selectedScentStyle;

  const ScentOption({
    super.key,
    required this.scentOption,
    this.onScentSelected,
    this.showLabel = false,
    this.padding,
    this.selectionColor,
    this.selectedBorderWidth = 1.5,
    this.borderRadius,
    this.labelStyle,
    this.selectedScentStyle,
  });

  @override
  State<ScentOption> createState() => _ScentOptionState();
}

class _ScentOptionState extends State<ScentOption> {
  int? selectedIndex;

  Color _getSelectionColor(BuildContext context) {
    return widget.selectionColor ?? Theme.of(context).colorScheme.primary;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.scentOption.isEmpty) return const SizedBox.shrink();

    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDarkMode = theme.brightness == Brightness.dark;
    final selectionColor = _getSelectionColor(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.showLabel)
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Text(
              'Scent',
              style: widget.labelStyle ??
                  theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colorScheme.onSurface,
                  ),
            ),
          ),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: List.generate(widget.scentOption.length, (index) {
            final scentName = widget.scentOption[index];
            final isSelected = index == selectedIndex;

            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedIndex = index;
                });
                widget.onScentSelected?.call(scentName);
              },
              child: Container(
                padding: widget.padding ??
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: isSelected
                        ? selectionColor
                        : isDarkMode
                            ? Colors.grey.shade700
                            : Colors.grey.shade300,
                    width: isSelected ? widget.selectedBorderWidth : 1.0,
                  ),
                  borderRadius: widget.borderRadius ?? BorderRadius.circular(8),
                  color: isSelected
                      // ignore: deprecated_member_use
                      ? selectionColor.withOpacity(0.15)
                      : isDarkMode
                          ? Colors.grey.shade800
                          : Colors.transparent,
                ),
                child: Text(
                  scentName,
                  style: widget.selectedScentStyle ??
                      theme.textTheme.bodyMedium?.copyWith(
                        color: isSelected
                            ? selectionColor
                            : isDarkMode
                                ? colorScheme.onSurfaceVariant
                                : Colors.black,
                        fontWeight:
                            isSelected ? FontWeight.bold : FontWeight.normal,
                      ),
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }),
        ),
      ],
    );
  }
}
