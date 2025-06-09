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
        } else if (state is ReviewsLoaded) {
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
                child: RatingDistribution(reviews: state.reviews),
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
              if (state.reviews.isNotEmpty) ...[
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
                        '${state.reviews.length} reviews',
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
                child: ReviewList(
                  productId: widget.productId!,
                  reviews: state.reviews,
                  scrollable: !widget.isEmbedded,
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
