import 'dart:convert';
import 'package:pickpay/core/utils/backend_endpoints.dart';
import 'package:pickpay/features/reviews/models/review_model.dart';
import 'package:pickpay/services/api_service.dart';

class ReviewService {
  final ApiService apiService;

  ReviewService(this.apiService);

  /// Fetch all reviews for a product
  Future<List<Review>> getReviews(String productId) async {
    try {
      final response = await apiService.get(
        endpoint: BackendEndpoints.getReviewsByProduct(productId),
        authorized: false,
      );

      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);
        final List<dynamic> reviewsJson = decoded['data'];
        return reviewsJson.map((json) => Review.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load reviews: ${response.body}');
      }
    } catch (e) {
      rethrow;
    }
  }

  /// Add a review to a product (requires auth)
  Future<Review> addReview({
    required String productId,
    required double rating,
    required String reviewText,
  }) async {
    try {
      final response = await apiService.post(
        endpoint: BackendEndpoints.getReviewsByProduct(productId),
        body: {
          'rating': rating,
          'review': reviewText,
        },
        authorized: true,
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        final decoded = jsonDecode(response.body);
        return Review.fromJson(decoded['data']);
      } else {
        throw Exception('Failed to add review: ${response.body}');
      }
    } catch (e) {
      rethrow;
    }
  }
}
