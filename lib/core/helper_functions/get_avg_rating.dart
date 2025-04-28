import 'package:pickpay/core/entities/review_entity.dart';

num getAvgRating(List<ReviewEntity> reviews) {
  double sum = 0;
  for (var review in reviews) {
    sum += review.rating;
  }
  return sum / reviews.length;
}
