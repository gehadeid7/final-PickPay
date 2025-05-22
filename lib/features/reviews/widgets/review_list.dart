import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pickpay/core/services/shared_preferences_singletone.dart';
import 'package:pickpay/features/auth/data/models/user_model.dart';
import '../models/review_model.dart';
import '../cubit/review_cubit.dart';
import 'review_card.dart';

class ReviewList extends StatelessWidget {
  final String? productId;
  final List<Review> reviews;
  final bool scrollable;

  const ReviewList({
    Key? key,
    this.productId,
    required this.reviews,
    this.scrollable = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentUser = Prefs.getUser();

    if (reviews.isEmpty) {
      return Container(
        height: 200,
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.rate_review_outlined,
              size: 64,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              'No reviews yet. Be the first to review!',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      shrinkWrap: !scrollable,
      physics: scrollable
          ? const AlwaysScrollableScrollPhysics()
          : const NeverScrollableScrollPhysics(),
      itemCount: reviews.length,
      padding: EdgeInsets.zero,
      itemBuilder: (context, index) {
        return Provider<UserModel>.value(
          value: currentUser!,
          child: ReviewCard(
            review: reviews[index],
            onDeleted: () {
              // Refresh the reviews after deletion
              context.read<ReviewCubit>().fetchReviews(productId: productId);
            },
          ),
        );
      },
    );
  }
}
