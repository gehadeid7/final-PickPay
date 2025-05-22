import 'package:flutter/material.dart';
import '../models/review_model.dart';

class RatingDistribution extends StatelessWidget {
  final List<Review> reviews;

  const RatingDistribution({
    Key? key,
    required this.reviews,
  }) : super(key: key);

  Map<int, int> _calculateRatingDistribution() {
    final distribution = <int, int>{};
    for (var i = 1; i <= 5; i++) {
      distribution[i] = reviews.where((r) => r.rating.round() == i).length;
    }
    return distribution;
  }

  double _calculateAverageRating() {
    if (reviews.isEmpty) return 0;
    final sum = reviews.fold(0.0, (sum, review) => sum + review.rating);
    return sum / reviews.length;
  }

  double _calculatePercentage(int count) {
    if (reviews.isEmpty) return 0;
    return (count / reviews.length) * 100;
  }

  @override
  Widget build(BuildContext context) {
    final distribution = _calculateRatingDistribution();
    final averageRating = _calculateAverageRating();
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text(
                        averageRating.toStringAsFixed(1),
                        style: TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                          color: isDarkMode ? Colors.white : Colors.black,
                        ),
                      ),
                      Text(
                        ' / 5',
                        style: TextStyle(
                          fontSize: 20,
                          color:
                              isDarkMode ? Colors.grey[400] : Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${reviews.length} ratings',
                    style: TextStyle(
                      fontSize: 14,
                      color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(5, (index) {
                      return Icon(
                        index < averageRating
                            ? Icons.star
                            : index < averageRating.floor() + 0.5
                                ? Icons.star_half
                                : Icons.star_border,
                        color: Colors.amber,
                        size: 20,
                      );
                    }),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              flex: 3,
              child: Column(
                children: [
                  for (var i = 5; i >= 1; i--)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Row(
                        children: [
                          Text(
                            '$i',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: isDarkMode
                                  ? Colors.grey[300]
                                  : Colors.grey[700],
                            ),
                          ),
                          const SizedBox(width: 8),
                          Icon(
                            Icons.star,
                            color: Colors.amber,
                            size: 14,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(4),
                              child: TweenAnimationBuilder<double>(
                                duration: const Duration(milliseconds: 800),
                                curve: Curves.easeOutQuart,
                                tween: Tween<double>(
                                  begin: 0,
                                  end: _calculatePercentage(
                                          distribution[i] ?? 0) /
                                      100,
                                ),
                                builder: (context, value, _) => Stack(
                                  children: [
                                    Container(
                                      height: 8,
                                      color: isDarkMode
                                          ? Colors.grey[700]
                                          : Colors.grey[200],
                                    ),
                                    FractionallySizedBox(
                                      widthFactor: value,
                                      child: Container(
                                        height: 8,
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            colors: [
                                              Colors.amber.shade300,
                                              Colors.amber.shade500,
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          SizedBox(
                            width: 32,
                            child: Text(
                              '${distribution[i]}',
                              style: TextStyle(
                                fontSize: 14,
                                color: isDarkMode
                                    ? Colors.grey[400]
                                    : Colors.grey[600],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
