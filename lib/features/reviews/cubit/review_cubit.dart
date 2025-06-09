import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pickpay/services/api_service.dart';
import '../models/review_model.dart';
import 'review_state.dart';

class ReviewCubit extends Cubit<ReviewState> {
  final ApiService apiService;

  ReviewCubit({required this.apiService}) : super(ReviewInitial());

  Future<void> submitReview({
    required String productId,
    required double rating,
    required String reviewContent,
  }) async {
    emit(ReviewLoading());
    try {
      final response = await apiService.createReview(
        productId: productId,
        rating: rating,
        review: reviewContent, // now this will be sent as 'content' in the POST body
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        emit(ReviewSubmitted());
        await fetchReviews(productId: productId);
      } else {
        emit(ReviewError('Failed to submit review: \\${response.body}'));
      }
    } catch (e) {
      emit(ReviewError(e.toString()));
    }
  }

  Future<void> fetchReviews({required String productId}) async {
    emit(ReviewLoading());
    try {
      final data = await apiService.getReviewsByProduct(productId);
      final reviews = data.map((e) => Review.fromJson(e)).toList();
      emit(ReviewsLoaded(reviews));
    } catch (e) {
      emit(ReviewError('Failed to load reviews: $e'));
    }
  }

  Future<void> updateReview({
    required String reviewId,
    double? rating,
    String? reviewContent,
    required String productId,
  }) async {
    emit(ReviewLoading());
    try {
      final response = await apiService.updateReview(
        reviewId: reviewId,
        rating: rating,
        review: reviewContent,
      );

      if (response.statusCode == 200) {
        emit(ReviewUpdated());
        await fetchReviews(productId: productId);
      } else {
        emit(ReviewError('Failed to update review: ${response.body}'));
      }
    } catch (e) {
      emit(ReviewError('Update failed: $e'));
    }
  }

  Future<void> deleteReview({
    required String reviewId,
    required String productId,
  }) async {
    emit(ReviewLoading());
    try {
      final response = await apiService.deleteReview(reviewId);

      if (response.statusCode == 204) {
        emit(ReviewDeleted());
        await fetchReviews(productId: productId);
      } else {
        emit(ReviewError('Failed to delete review: ${response.body}'));
      }
    } catch (e) {
      emit(ReviewError('Delete failed: $e'));
    }
  }
}
