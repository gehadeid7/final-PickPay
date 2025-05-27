import 'package:flutter/material.dart';

class PriceRangeFilterWidget extends StatefulWidget {
  final RangeValues values;
  final double maxPrice;
  final ValueChanged<RangeValues> onChanged;

  const PriceRangeFilterWidget({
    Key? key,
    required this.values,
    required this.maxPrice,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<PriceRangeFilterWidget> createState() => _PriceRangeFilterWidgetState();
}

class _PriceRangeFilterWidgetState extends State<PriceRangeFilterWidget> {
  late RangeValues _currentValues;

  @override
  void initState() {
    super.initState();
    _currentValues = widget.values;
  }

  @override
  void didUpdateWidget(PriceRangeFilterWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.values != widget.values) {
      _currentValues = widget.values;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    final double safeStart = _currentValues.start.clamp(0.0, widget.maxPrice);
    final double safeEnd = _currentValues.end.clamp(safeStart, widget.maxPrice);
    final int divisions = (widget.maxPrice / 100).round().clamp(1, 100);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 8),
          child: Text(
            'Price Range',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: isDarkMode ? Colors.white : const Color(0xFF2C3E50),
              letterSpacing: -0.2,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isDarkMode ? Colors.grey.shade900 : Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color:
                  isDarkMode ? Colors.grey.shade800 : const Color(0xFFEEEEEE),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF9E9E9E).withOpacity(0.08),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: [
              SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  rangeThumbShape: const RoundRangeSliderThumbShape(
                    enabledThumbRadius: 8,
                    elevation: 4,
                    pressedElevation: 6,
                  ),
                  overlayShape:
                      const RoundSliderOverlayShape(overlayRadius: 20),
                  trackHeight: 4,
                  activeTrackColor: theme.colorScheme.primary,
                  inactiveTrackColor:
                      theme.colorScheme.primary.withOpacity(0.12),
                  thumbColor: theme.colorScheme.primary,
                  overlayColor: theme.colorScheme.primary.withOpacity(0.12),
                  activeTickMarkColor: Colors.transparent,
                  inactiveTickMarkColor: Colors.transparent,
                ),
                child: RangeSlider(
                  values: RangeValues(safeStart, safeEnd),
                  min: 0,
                  max: widget.maxPrice,
                  divisions: divisions,
                  labels: RangeLabels(
                    'EGP ${safeStart.round()}',
                    'EGP ${safeEnd.round()}',
                  ),
                  onChanged: (RangeValues values) {
                    setState(() {
                      _currentValues = values;
                    });
                    widget.onChanged(values);
                  },
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildPriceBox(context, safeStart),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      'to',
                      style: TextStyle(
                        color:
                            isDarkMode ? Colors.grey : const Color(0xFF9E9E9E),
                        fontSize: 12,
                      ),
                    ),
                  ),
                  _buildPriceBox(context, safeEnd),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPriceBox(BuildContext context, double value) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.grey.shade800 : const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isDarkMode ? Colors.grey.shade700 : const Color(0xFFEEEEEE),
          width: 1,
        ),
      ),
      child: Text(
        'EGP ${value.round()}',
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: isDarkMode ? Colors.white : const Color(0xFF2C3E50),
        ),
      ),
    );
  }
}
