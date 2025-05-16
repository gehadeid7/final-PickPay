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
    return ConstrainedBox(
      constraints: const BoxConstraints(
        minHeight: 80,
        maxHeight: 100,
      ),
      child: Card(
        elevation: 2,
        margin: EdgeInsets.zero,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
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
              Expanded(
                child: RangeSlider(
                  values: values,
                  min: 0,
                  max: maxPrice,
                  divisions: maxPrice > 0 ? 10 : 1,
                  activeColor: Colors.green,
                  inactiveColor: Colors.blue[100],
                  labels: RangeLabels(
                    'EGP ${values.start.round()}',
                    'EGP ${values.end.round()}',
                  ),
                  onChanged: onChanged,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'EGP ${values.start.round()}',
                      style: const TextStyle(fontSize: 11),
                    ),
                    Text(
                      'EGP ${values.end.round()}',
                      style: const TextStyle(fontSize: 11),
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
