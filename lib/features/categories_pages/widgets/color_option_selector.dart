import 'package:flutter/material.dart';

class ColorOptionSelector extends StatefulWidget {
  final List<String> colorOptions;
  final void Function(String selectedColorName)? onColorSelected;
  final bool showLabel;

  const ColorOptionSelector({
    super.key,
    required this.colorOptions,
    this.onColorSelected,
    this.showLabel = false, // default to false
  });

  @override
  State<ColorOptionSelector> createState() => _ColorOptionSelectorState();
}

class _ColorOptionSelectorState extends State<ColorOptionSelector> {
  int? selectedIndex;

  @override
  Widget build(BuildContext context) {
    if (widget.colorOptions.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.showLabel)
          const Padding(
            padding: EdgeInsets.only(bottom: 8),
            child: Text(
              'Color',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: List.generate(widget.colorOptions.length, (index) {
            final colorName = widget.colorOptions[index];
            final isSelected = index == selectedIndex;

            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedIndex = index;
                });
                widget.onColorSelected?.call(colorName);
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                decoration: BoxDecoration(
                  border:
                      Border.all(color: isSelected ? Colors.blue : Colors.grey),
                  borderRadius: BorderRadius.circular(6),
                  // ignore: deprecated_member_use
                  color: isSelected ? Colors.blue.withOpacity(0.1) : null,
                ),
                child: Text(
                  colorName,
                  style: const TextStyle(color: Colors.black),
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
