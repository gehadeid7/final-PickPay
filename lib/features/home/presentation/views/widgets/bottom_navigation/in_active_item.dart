import 'package:flutter/material.dart';

class InActiveItem extends StatelessWidget {
  const InActiveItem({
    super.key,
    required this.image,
  });

  final String image;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Container(
        width: 40,
        height: 40,
        alignment: Alignment.center,
        child: _buildImageWithErrorHandling(theme),
      ),
    );
  }

  Widget _buildImageWithErrorHandling(ThemeData theme) {
    return Image.asset(
      image,
      width: 30,
      height: 30,
      // ignore: deprecated_member_use
      color: theme.iconTheme.color?.withOpacity(0.6),
      errorBuilder: (context, error, stackTrace) => Icon(
        Icons.person_outline,
        size: 30,
        // ignore: deprecated_member_use
        color: theme.iconTheme.color?.withOpacity(0.6),
      ),
    );
  }
}
