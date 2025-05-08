import 'package:flutter/material.dart';

class ColorOptionSelector extends StatefulWidget {
  final List<String> colorOptions;
  final String? selectedColor; // Currently selected color value
  final ValueChanged<String>? onColorSelected;
  final bool showLabel;
  final bool showOutOfStock;
  final Map<String, bool>? colorAvailability;
  final bool showColorSwatches;
  final Map<String, Color>? colorValues;
  final double swatchSize;
  final EdgeInsetsGeometry? padding;
  final Color? selectionColor; // Color for selection highlight (renamed)
  final Color? outOfStockColor;
  final double selectedBorderWidth;
  final BorderRadius? borderRadius;
  final TextStyle? labelStyle;
  final TextStyle? selectedColorStyle;

  const ColorOptionSelector({
    super.key,
    required this.colorOptions,
    this.selectedColor,
    this.onColorSelected,
    this.showLabel = true,
    this.showOutOfStock = true,
    this.colorAvailability,
    this.showColorSwatches = true,
    this.colorValues,
    this.swatchSize = 24.0,
    this.padding,
    this.selectionColor, // Renamed parameter
    this.outOfStockColor,
    this.selectedBorderWidth = 2.0,
    this.borderRadius,
    this.labelStyle,
    this.selectedColorStyle,
  });

  @override
  State<ColorOptionSelector> createState() => _ColorOptionSelectorState();
}

class _ColorOptionSelectorState extends State<ColorOptionSelector> {
  String? _selectedColor;

  @override
  void initState() {
    super.initState();
    _selectedColor = widget.selectedColor;
  }

  @override
  void didUpdateWidget(ColorOptionSelector oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedColor != oldWidget.selectedColor) {
      _selectedColor = widget.selectedColor;
    }
  }

  bool _isColorAvailable(String color) {
    if (widget.colorAvailability == null) return true;
    return widget.colorAvailability?[color] ?? true;
  }

  Color? _getColorValue(String colorName) {
    if (widget.colorValues == null) return null;
    return widget.colorValues?[colorName];
  }

  Color _getSelectionColor() {
    return widget.selectionColor ?? Colors.blue.shade600; // Updated reference
  }

  Color _getOutOfStockColor(BuildContext context) {
    return widget.outOfStockColor ?? Theme.of(context).colorScheme.error;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.colorOptions.isEmpty) return const SizedBox.shrink();

    final selectionColor = _getSelectionColor();
    final selectionLightColor = selectionColor.withOpacity(0.1);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.showLabel)
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              children: [
                Text(
                  'Color',
                  style: widget.labelStyle ??
                      TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: colorScheme.onSurface,
                      ),
                ),
                if (_selectedColor != null)
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Text(
                      'Selected: $_selectedColor',
                      style: widget.selectedColorStyle ??
                          TextStyle(
                            fontSize: 14,
                            color: colorScheme.onSurface.withOpacity(0.6),
                          ),
                    ),
                  ),
              ],
            ),
          ),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: widget.colorOptions.map((color) {
            final isSelected = color == _selectedColor;
            final isAvailable = _isColorAvailable(color);
            final colorValue = _getColorValue(color);

            return Tooltip(
              message: !isAvailable ? '$color (Out of stock)' : color,
              child: GestureDetector(
                onTap: isAvailable
                    ? () {
                        setState(() {
                          _selectedColor = color;
                        });
                        widget.onColorSelected?.call(color);
                      }
                    : null,
                child: IntrinsicWidth(
                  child: Container(
                    padding: widget.padding ??
                        const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 16),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color:
                            isSelected ? selectionColor : Colors.grey.shade300,
                        width: isSelected ? widget.selectedBorderWidth : 1.0,
                      ),
                      borderRadius:
                          widget.borderRadius ?? BorderRadius.circular(8),
                      color:
                          isSelected ? selectionLightColor : Colors.transparent,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (widget.showColorSwatches && colorValue != null)
                          Container(
                            width: widget.swatchSize,
                            height: widget.swatchSize,
                            margin: const EdgeInsets.only(right: 8),
                            decoration: BoxDecoration(
                              color: colorValue,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: isSelected
                                    ? selectionColor
                                    : Colors.grey.shade300,
                                width: 1,
                              ),
                            ),
                          ),
                        Text(
                          color,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: isAvailable
                                ? isSelected
                                    ? selectionColor
                                    : Colors.black
                                : Colors.grey,
                            decoration: !isAvailable && widget.showOutOfStock
                                ? TextDecoration.lineThrough
                                : null,
                          ),
                        ),
                        // if (!isAvailable && widget.showOutOfStock)
                        //   const Text(
                        //     'X',
                        //     style: TextStyle(
                        //       fontSize: 12,
                        //       color: Colors.red,
                        //       fontWeight: FontWeight.bold,
                        //     ),
                        //   ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
