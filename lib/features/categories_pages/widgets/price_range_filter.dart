import 'package:flutter/material.dart';

class PriceRangeFilterWidget extends StatelessWidget {
  final RangeValues values;
  final double maxPrice;
  final ValueChanged<RangeValues> onChanged;

  // ignore: use_super_parameters
  const PriceRangeFilterWidget({
    Key? key,
    required this.values,
    required this.maxPrice,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                    rangeThumbShape: RoundRangeSliderThumbShape(
                      enabledThumbRadius: 8,
                      disabledThumbRadius: 8,
                    ),
                    trackHeight: 4,
                  ),
                  child: RangeSlider(
                    values: values,
                    min: 0,
                    max: maxPrice,
                    divisions: maxPrice > 0 ? 10 : 1,
                    activeColor: Colors.green,
                    inactiveColor: Colors.blue[100],
                    onChanged: onChanged,
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 4, right: 4), // Reduced padding
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'EGP ${values.start.round()}',
                      style: const TextStyle(fontSize: 10), // Reduced font size
                    ),
                    Text(
                      'EGP ${values.end.round()}',
                      style: const TextStyle(fontSize: 10), // Reduced font size
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
