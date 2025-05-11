import 'package:flutter/material.dart';

class SizeOptionSelector extends StatefulWidget {
  final List<String> availableSizes;
  final String? selectedSize;
  final void Function(String selectedSize)? onSizeSelected;
  final bool showLabel;
  final bool showOutOfStock;
  final Map<String, bool>? sizeAvailability;
  final EdgeInsetsGeometry? padding;
  final Color? selectedColor;

  const SizeOptionSelector({
    super.key,
    required this.availableSizes,
    this.selectedSize,
    this.onSizeSelected,
    this.showLabel = true,
    this.showOutOfStock = true,
    this.sizeAvailability,
    this.padding,
    this.selectedColor, // Can override the default blue if needed
  });

  @override
  State<SizeOptionSelector> createState() => _SizeOptionSelectorState();
}

class _SizeOptionSelectorState extends State<SizeOptionSelector> {
  String? _selectedSize;

  @override
  void initState() {
    super.initState();
    _selectedSize = widget.selectedSize;
  }

  @override
  void didUpdateWidget(SizeOptionSelector oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedSize != oldWidget.selectedSize) {
      _selectedSize = widget.selectedSize;
    }
  }

  bool _isSizeAvailable(String size) {
    if (widget.sizeAvailability == null) return true;
    return widget.sizeAvailability?[size] ?? true;
  }

  Color _getSelectionColor(BuildContext context) {
    // Use custom color if provided, otherwise use theme's primary (blue)
    return widget.selectedColor ?? Theme.of(context).colorScheme.primary;
  }

  Color _getOutOfStockColor(BuildContext context) {
    return Theme.of(context).colorScheme.error;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.availableSizes.isEmpty) return const SizedBox.shrink();

    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDarkMode = theme.brightness == Brightness.dark;
    final selectionColor = _getSelectionColor(context);
    // ignore: deprecated_member_use
    final selectionLightColor = selectionColor.withOpacity(0.15);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.showLabel)
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              children: [
                Text(
                  'Size',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: colorScheme.onSurface,
                  ),
                ),
                if (_selectedSize != null)
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Text(
                      'Selected: $_selectedSize',
                      style: TextStyle(
                        fontSize: 14,
                        // ignore: deprecated_member_use
                        color: colorScheme.onSurface.withOpacity(0.6),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: widget.availableSizes.map((size) {
            final isSelected = size == _selectedSize;
            final isAvailable = _isSizeAvailable(size);

            return Tooltip(
              message: !isAvailable ? 'Out of stock' : size,
              child: GestureDetector(
                onTap: isAvailable
                    ? () {
                        setState(() {
                          _selectedSize = size;
                        });
                        widget.onSizeSelected?.call(size);
                      }
                    : null,
                child: IntrinsicWidth(
                  child: Container(
                    padding: widget.padding ??
                        const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 16),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: isSelected
                            ? selectionColor // Blue selection border
                            : isDarkMode
                                ? Colors.grey.shade700
                                : Colors.grey.shade300,
                        width: isSelected ? 2 : 1,
                      ),
                      borderRadius: BorderRadius.circular(8),
                      color: isSelected
                          ? selectionLightColor // Light blue background when selected
                          : isDarkMode
                              ? Colors.grey.shade800
                              : Colors.transparent,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          size,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: isAvailable
                                ? isSelected
                                    ? selectionColor // Blue text when selected
                                    : isDarkMode
                                        ? Colors.white
                                        : Colors.black
                                : _getOutOfStockColor(context),
                            decoration: !isAvailable && widget.showOutOfStock
                                ? TextDecoration.lineThrough
                                : null,
                          ),
                        ),
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
