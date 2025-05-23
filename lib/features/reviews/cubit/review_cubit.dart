import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/review_model.dart';
import 'review_state.dart';

class ReviewCubit extends Cubit<ReviewState> {
  final FirebaseFirestore _firestore;
  bool _isClosed = false;

  ReviewCubit({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance,
        super(ReviewInitial());

  @override
  Future<void> close() {
    _isClosed = true;
    return super.close();
  }

  void _safeEmit(ReviewState state) {
    if (!_isClosed && !isClosed) {
      emit(state);
    }
  }

  Future<void> submitReview({
    required String userId,
    required String userImage,
    required String userName,
    required String content,
    required double rating,
    String? productId,
  }) async {
    try {
      _safeEmit(ReviewLoading());

      final reviewRef = _firestore.collection('reviews').doc();
      final review = Review(
        id: reviewRef.id,
        userId: userId,
        userImage: userImage,
        userName: userName,
        content: content,
        rating: rating,
        createdAt: DateTime.now(),
        productId: productId,
      );

      await reviewRef.set(review.toJson());
      _safeEmit(ReviewSubmitted());
      await fetchReviews(productId: productId);
    } catch (e) {
      _safeEmit(ReviewError(e.toString()));
    }
  }

  Future<void> fetchReviews({String? productId}) async {
    try {
      _safeEmit(ReviewLoading());

      Query query = _firestore.collection('reviews');

      if (productId != null) {
        query = query.where('productId', isEqualTo: productId);
      }

      final querySnapshot = await query.get();
      final reviews = querySnapshot.docs
          .map((doc) => Review.fromJson(doc.data() as Map<String, dynamic>))
          .toList();

      reviews.sort((a, b) => b.createdAt.compareTo(a.createdAt));

      _safeEmit(ReviewsLoaded(reviews));
    } catch (e) {
      _safeEmit(ReviewError(e.toString()));
    }
  }

  Future<void> deleteReview(String reviewId) async {
    try {
      // Get the review document to get its productId before deletion
      final reviewDoc =
          await _firestore.collection('reviews').doc(reviewId).get();

      if (!reviewDoc.exists) {
        _safeEmit(ReviewError('Review not found'));
        return;
      }

      final productId = reviewDoc.data()?['productId'] as String?;

      // Delete the review
      await _firestore.collection('reviews').doc(reviewId).delete();

      // Emit deleted state before fetching updated reviews
      _safeEmit(ReviewDeleted());

      // Fetch updated reviews to refresh the list
      if (productId != null) {
        await fetchReviews(productId: productId);
      }
    } catch (e) {
      _safeEmit(ReviewError('Failed to delete review: $e'));
    }
  }
}
