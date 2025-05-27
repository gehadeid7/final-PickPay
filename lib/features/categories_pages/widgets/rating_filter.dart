import 'package:flutter/material.dart';

class RatingFilterWidget extends StatelessWidget {
  final double value;
  final ValueChanged<double> onChanged;

  const RatingFilterWidget({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 8),
          child: Text(
            'Customer Reviews',
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
              Row(
                children: [
                  Icon(
                    Icons.star_rounded,
                    size: 20,
                    color: Colors.amber.shade400,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        thumbShape: RoundSliderThumbShape(
                          enabledThumbRadius: 6,
                          elevation: 2,
                          pressedElevation: 4,
                        ),
                        overlayShape:
                            RoundSliderOverlayShape(overlayRadius: 16),
                        trackHeight: 4,
                        activeTrackColor: Colors.amber.shade400,
                        inactiveTrackColor: Colors.amber.shade100,
                        thumbColor: Colors.white,
                        overlayColor: Colors.amber.withOpacity(0.12),
                      ),
                      child: Slider(
                        value: value,
                        min: 0,
                        max: 5,
                        divisions: 10,
                        onChanged: onChanged,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 8),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.amber.shade400.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: Colors.amber.shade400.withOpacity(0.2),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          value.toStringAsFixed(1),
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.amber.shade700,
                            letterSpacing: -0.2,
                          ),
                        ),
                        const SizedBox(width: 2),
                        Icon(
                          Icons.star_rounded,
                          size: 12,
                          color: Colors.amber.shade700,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(
                  6,
                  (index) => Text(
                    '$index',
                    style: TextStyle(
                      fontSize: 10,
                      color: isDarkMode ? Colors.grey : const Color(0xFF9E9E9E),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
