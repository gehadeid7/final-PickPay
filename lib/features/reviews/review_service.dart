import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pickpay/features/reviews/models/review_model.dart';

class ReviewService {
  final String baseUrl;

  ReviewService({required this.baseUrl});

  Future<List<Review>> getReviews(String productId) async {
    final response =
        await http.get(Uri.parse('$baseUrl/reviews?productId=$productId'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => Review.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load reviews');
    }
  }

  Future<Review> addReview(Review review) async {
    final response = await http.post(
      Uri.parse('$baseUrl/reviews'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(review.toJson()),
    );

    if (response.statusCode == 201) {
      return Review.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to add review');
    }
  }
}
