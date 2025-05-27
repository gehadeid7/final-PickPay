import 'package:flutter/material.dart';

class PriceRangeFilterWidget extends StatelessWidget {
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
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    final double safeStart = values.start.clamp(0.0, maxPrice);
    final double safeEnd = values.end.clamp(0.0, maxPrice);
    final RangeValues safeValues = RangeValues(safeStart, safeEnd);

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
                  rangeThumbShape: RoundRangeSliderThumbShape(
                    enabledThumbRadius: 6,
                    elevation: 2,
                    pressedElevation: 4,
                  ),
                  overlayShape: RoundSliderOverlayShape(overlayRadius: 16),
                  trackHeight: 4,
                  activeTrackColor: theme.colorScheme.primary,
                  inactiveTrackColor:
                      theme.colorScheme.primary.withOpacity(0.12),
                  thumbColor: Colors.white,
                  overlayColor: theme.colorScheme.primary.withOpacity(0.12),
                ),
                child: RangeSlider(
                  values: safeValues,
                  min: 0,
                  max: maxPrice > 0 ? maxPrice : 1,
                  divisions: maxPrice > 0 ? 100 : 1,
                  onChanged: onChanged,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildPriceBox(context, safeValues.start),
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
                  _buildPriceBox(context, safeValues.end),
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
