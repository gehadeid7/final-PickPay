import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:provider/provider.dart';
import 'package:pickpay/features/auth/data/models/user_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/review_model.dart';
import '../cubit/review_cubit.dart';
import '../cubit/review_state.dart';

class ReviewCard extends StatefulWidget {
  final Review review;
  final Function()? onDeleted;

  const ReviewCard({
    Key? key,
    required this.review,
    this.onDeleted,
  }) : super(key: key);

  @override
  State<ReviewCard> createState() => _ReviewCardState();
}

class _ReviewCardState extends State<ReviewCard> {
  late final ReviewCubit _reviewCubit;
  bool _isDeleting = false;

  @override
  void initState() {
    super.initState();
    _reviewCubit = context.read<ReviewCubit>();
  }

  Widget _buildUserAvatar(BuildContext context, bool isDarkMode) {
    return CircleAvatar(
      radius: 20,
      backgroundColor: isDarkMode ? Colors.grey[700] : Colors.grey[200],
      child: widget.review.userImage.isNotEmpty
          ? ClipOval(
              child: Image.network(
                widget.review.userImage,
                width: 40,
                height: 40,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return (widget.review.userName.isNotEmpty)
                      ? Text(
                          widget.review.userName[0].toUpperCase(),
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: isDarkMode ? Colors.white : Colors.grey[700],
                          ),
                        )
                      : Icon(Icons.person, color: isDarkMode ? Colors.white : Colors.grey[700]);
                },
              ),
            )
          : (widget.review.userName.isNotEmpty
              ? Text(
                  widget.review.userName[0].toUpperCase(),
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: isDarkMode ? Colors.white : Colors.grey[700],
                  ),
                )
              : Icon(Icons.person, color: isDarkMode ? Colors.white : Colors.grey[700])),
    );
  }

  Future<void> _handleDelete(BuildContext context, bool isDarkMode) async {
    if (_isDeleting) return;
    final reviewId = widget.review.id;
    final productId = widget.review.productId ?? '';
    if (reviewId.isEmpty || productId.isEmpty) {
      String missing = '';
      if (reviewId.isEmpty && productId.isEmpty) {
        missing = 'Review ID and Product ID are missing.';
      } else if (reviewId.isEmpty) {
        missing = 'Review ID is missing.';
      } else {
        missing = 'Product ID is missing.';
      }
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: ' + missing),
            backgroundColor: Colors.red,
          ),
        );
      }
      return;
    }
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          backgroundColor: isDarkMode ? Colors.grey[850] : Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          title: Text(
            'Delete Review',
            style: TextStyle(
              color: isDarkMode ? Colors.white : Colors.black,
            ),
          ),
          content: Text(
            'Are you sure you want to delete this review?',
            style: TextStyle(
              color: isDarkMode ? Colors.grey[300] : Colors.grey[700],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(false),
              child: Text(
                'Cancel',
                style: TextStyle(
                  color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
                ),
              ),
            ),
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(true),
              child: Text(
                'Delete',
                style: TextStyle(
                  color: Colors.red[400],
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );

    if (confirmed == true && mounted) {
      setState(() => _isDeleting = true);
      try {
        await _reviewCubit.deleteReview(
          reviewId: reviewId,
          productId: productId,
        );
        if (mounted && widget.onDeleted != null) {
          widget.onDeleted!();
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Failed to delete review: $e'),
              backgroundColor: Colors.red,
            ),
          );
        }
      } finally {
        if (mounted) {
          setState(() => _isDeleting = false);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    final currentUser = context.read<UserModel>();
    final isOwner = currentUser.uId == widget.review.userId;

    return BlocListener<ReviewCubit, ReviewState>(
      listener: (context, state) {
        if (state is ReviewDeleted && widget.onDeleted != null) {
          widget.onDeleted!();
        } else if (state is ReviewError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: Card(
        elevation: 0,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(
            color: isDarkMode ? Colors.grey[800]! : Colors.grey[200]!,
          ),
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      _buildUserAvatar(context, isDarkMode),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.review.userName,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              timeago.format(widget.review.createdAt),
                              style: TextStyle(
                                color: isDarkMode
                                    ? Colors.grey[400]
                                    : Colors.grey[600],
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (isOwner && !_isDeleting) ...[
                        IconButton(
                          icon: Icon(
                            Icons.edit_outlined,
                            color: theme.primaryColor,
                          ),
                          tooltip: 'Edit Review',
                          onPressed: () async {
                            final result = await showDialog<Map<String, dynamic>>(
                              context: context,
                              builder: (context) {
                                final _editController = TextEditingController(text: widget.review.content);
                                double _editRating = widget.review.rating;
                                return StatefulBuilder(
                                  builder: (context, setState) {
                                    return AlertDialog(
                                      backgroundColor: isDarkMode ? Colors.grey[850] : Colors.white,
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                      title: Text('Edit Review', style: TextStyle(color: isDarkMode ? Colors.white : Colors.black)),
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          TextFormField(
                                            controller: _editController,
                                            maxLines: 3,
                                            decoration: InputDecoration(
                                              labelText: 'Your Review',
                                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                                            ),
                                          ),
                                          const SizedBox(height: 16),
                                          Row(
                                            children: [
                                              const Text('Rating:'),
                                              const SizedBox(width: 8),
                                              Expanded(
                                                child: Slider(
                                                  value: _editRating,
                                                  min: 1,
                                                  max: 5,
                                                  divisions: 4,
                                                  label: _editRating.toStringAsFixed(1),
                                                  onChanged: (v) {
                                                    setState(() => _editRating = v);
                                                  },
                                                ),
                                              ),
                                              Text(_editRating.toStringAsFixed(1)),
                                            ],
                                          ),
                                        ],
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () => Navigator.of(context).pop(),
                                          child: const Text('Cancel'),
                                        ),
                                        ElevatedButton(
                                          onPressed: () {
                                            Navigator.of(context).pop({
                                              'content': _editController.text,
                                              'rating': _editRating,
                                            });
                                          },
                                          child: const Text('Save'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                            );
                            if (result != null && result['content'] != null && result['rating'] != null) {
                              if (widget.review.id.isEmpty || (widget.review.productId ?? '').isEmpty) {
                                String missing = '';
                                if (widget.review.id.isEmpty && (widget.review.productId ?? '').isEmpty) {
                                  missing = 'Review ID and Product ID are missing.';
                                } else if (widget.review.id.isEmpty) {
                                  missing = 'Review ID is missing.';
                                } else {
                                  missing = 'Product ID is missing.';
                                }
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Error: ' + missing),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                                return;
                              }
                              await _reviewCubit.updateReview(
                                reviewId: widget.review.id,
                                rating: result['rating'],
                                reviewContent: result['content'],
                                productId: widget.review.productId ?? '',
                              );
                            }
                          },
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.delete_outline,
                            color: Colors.red[400],
                          ),
                          onPressed: () => _handleDelete(context, isDarkMode),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Row(
                        children: List.generate(5, (index) {
                          return Icon(
                            index < widget.review.rating.floor()
                                ? Icons.star_rounded
                                : Icons.star_outline_rounded,
                            color: Colors.amber,
                            size: 20,
                          );
                        }),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        widget.review.rating.toString(),
                        style: TextStyle(
                          color:
                              isDarkMode ? Colors.grey[300] : Colors.grey[700],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    widget.review.content,
                    style: TextStyle(
                      color: isDarkMode ? Colors.grey[300] : Colors.grey[700],
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
            if (_isDeleting)
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
