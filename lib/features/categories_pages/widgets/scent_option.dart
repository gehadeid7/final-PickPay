import 'package:flutter/material.dart';

class ScentOption extends StatefulWidget {
  final List<String> scentOption;
  final void Function(String selectedScent)? onScentSelected;
  final bool showLabel;

  const ScentOption({
    super.key,
    required this.scentOption,
    this.onScentSelected,
    this.showLabel = false,
  });

  @override
  State<ScentOption> createState() => _ScentOptionState();
}

class _ScentOptionState extends State<ScentOption> {
  int? selectedIndex;

  @override
  Widget build(BuildContext context) {
    if (widget.scentOption.isEmpty) return const SizedBox.shrink();

    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDarkMode = theme.brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.showLabel)
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Text(
              'Scent',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: List.generate(widget.scentOption.length, (index) {
            final scentName = widget.scentOption[index];
            final isSelected = index == selectedIndex;
            final selectionColor = colorScheme.primary; // Blue from theme

            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedIndex = index;
                });
                widget.onScentSelected?.call(scentName);
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: isSelected
                        ? selectionColor
                        : isDarkMode
                            ? colorScheme.outline
                            : Colors.grey.shade300,
                    width: isSelected ? 1.5 : 1,
                  ),
                  borderRadius: BorderRadius.circular(8),
                  color: isSelected
                      // ignore: deprecated_member_use
                      ? selectionColor.withOpacity(0.15)
                      : isDarkMode
                          // ignore: deprecated_member_use
                          ? colorScheme.surfaceVariant
                          : null,
                ),
                child: Text(
                  scentName,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: isSelected
                        ? selectionColor
                        : isDarkMode
                            ? colorScheme.onSurface
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
