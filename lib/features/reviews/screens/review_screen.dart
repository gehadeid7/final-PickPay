import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:pickpay/core/services/shared_preferences_singletone.dart';
import 'package:pickpay/features/auth/data/models/user_model.dart';
import '../cubit/review_cubit.dart';
import '../cubit/review_state.dart';
import '../widgets/review_form.dart';
import '../widgets/review_list.dart';
import '../widgets/rating_distribution.dart';

class ReviewScreen extends StatefulWidget {
  final String? productId;
  final bool isEmbedded;

  const ReviewScreen({
    Key? key,
    this.productId,
    this.isEmbedded = false,
  }) : super(key: key);

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  late final UserModel? currentUser;
  bool _showReviewForm = false;
  late final ReviewCubit _reviewCubit;

  @override
  void initState() {
    super.initState();
    currentUser = Prefs.getUser();
    _reviewCubit = context.read<ReviewCubit>();
    _loadReviews();
  }

  @override
  void dispose() {
    if (!widget.isEmbedded) {
      // Only close the cubit if this screen is not embedded
      _reviewCubit.close();
    }
    super.dispose();
  }

  Future<void> _loadReviews() async {
    if (mounted && widget.productId != null) {
      await _reviewCubit.fetchReviews(productId: widget.productId!);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final theme = Theme.of(context);

    return BlocBuilder<ReviewCubit, ReviewState>(
      builder: (context, state) {
        if (state is ReviewLoading) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: CircularProgressIndicator(),
            ),
          );
        } else if (state is ReviewError) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.error_outline,
                    color: Colors.red[400],
                    size: 48,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    state.message,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: isDarkMode ? Colors.grey[300] : Colors.grey[700],
                    ),
                  ),
                ],
              ),
            ),
          );
        } else if (state is ReviewsLoaded || state is ReviewSubmitted) {
          // If review was just submitted, close the form
          if (state is ReviewSubmitted && _showReviewForm) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (mounted) setState(() => _showReviewForm = false);
            });
          }
          final reviews = state is ReviewsLoaded ? state.reviews : (_reviewCubit.state as ReviewsLoaded).reviews;
          // DEBUG LOG: Print all reviews and their content
          for (final review in reviews) {
            // ignore: avoid_print
            print('[ReviewScreen] Review by: \\${review.userName} | Content: \\${review.content} | Rating: \\${review.rating}');
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: isDarkMode ? Colors.grey[850] : Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isDarkMode ? Colors.grey[700]! : Colors.grey[200]!,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: RatingDistribution(reviews: reviews),
              ),
              // Always show the review button and form as part of the UI
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16.0),
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _showReviewForm = !_showReviewForm;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isDarkMode
                        ? theme.primaryColor.withOpacity(0.2)
                        : theme.primaryColor.withOpacity(0.1),
                    foregroundColor: theme.primaryColor,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: BorderSide(
                        color: theme.primaryColor.withOpacity(0.5),
                        width: 1.5,
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        _showReviewForm ? Icons.close : Icons.rate_review,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        _showReviewForm ? 'Cancel Review' : 'Write a Review',
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (_showReviewForm)
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.only(top: 16.0),
                  child: Provider<UserModel>.value(
                    value: currentUser ?? UserModel(uId: '', email: '', fullName: '', phone: '', emailVerified: false),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: ReviewForm(productId: widget.productId!),
                    ),
                  ),
                ),
              if (reviews.isNotEmpty) ...[
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 16.0),
                  child: Row(
                    children: [
                      Container(
                        width: 4,
                        height: 24,
                        decoration: BoxDecoration(
                          color: theme.primaryColor,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        'Customer Reviews',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: isDarkMode ? Colors.white : Colors.black87,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        '${reviews.length} reviews',
                        style: TextStyle(
                          color:
                              isDarkMode ? Colors.grey[400] : Colors.grey[600],
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    if (reviews.any((r) => r.id.isEmpty || (r.productId ?? '').isEmpty))
                      Container(
                        margin: const EdgeInsets.only(bottom: 8),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.red[50],
                          border: Border.all(color: Colors.red[200]!),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.warning, color: Colors.red, size: 20),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                'Warning: One or more reviews are missing their ID or product ID. Edit/delete will not work for these.',
                                style: const TextStyle(color: Colors.red, fontWeight: FontWeight.w600),
                              ),
                            ),
                          ],
                        ),
                      ),
                    // Debug print for all reviews
                    ...reviews.map((r) {
                      // ignore: avoid_print
                      print('[DEBUG] ReviewCard: reviewId="${r.id}", productId="${r.productId}"');
                      return const SizedBox.shrink();
                    }),
                    ReviewList(
                      productId: widget.productId!,
                      reviews: reviews,
                      scrollable: !widget.isEmbedded,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
            ],
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
