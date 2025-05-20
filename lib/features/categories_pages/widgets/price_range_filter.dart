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
    // Clamp values to avoid assertion error
    final double safeStart = values.start.clamp(0.0, maxPrice);
    final double safeEnd = values.end.clamp(0.0, maxPrice);
    final RangeValues safeValues = RangeValues(safeStart, safeEnd);

    return SizedBox(
      height: 80,
      child: Card(
        elevation: 2,
        margin: EdgeInsets.zero,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Price Range',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 4),
              Expanded(
                child: SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    rangeThumbShape: const RoundRangeSliderThumbShape(
                      enabledThumbRadius: 8,
                      disabledThumbRadius: 8,
                    ),
                    trackHeight: 4,
                  ),
                  child: RangeSlider(
                    values: safeValues,
                    min: 0,
                    max: maxPrice > 0 ? maxPrice : 1,
                    divisions: maxPrice > 0 ? 10 : 1,
                    activeColor: Colors.green,
                    inactiveColor: Colors.blue[100],
                    onChanged: onChanged,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'EGP ${safeValues.start.round()}',
                      style: const TextStyle(fontSize: 10),
                    ),
                    Text(
                      'EGP ${safeValues.end.round()}',
                      style: const TextStyle(fontSize: 10),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
