import 'package:flutter/material.dart';

class InActiveItem extends StatelessWidget {
  const InActiveItem({
    super.key,
    required this.image,
  });

  final String image;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 40,
        height: 40,
        alignment: Alignment.center,
        child: _buildImageWithErrorHandling(),
      ),
    );
  }

  Widget _buildImageWithErrorHandling() {
    return Image.asset(
      image,
      width: 30,
      height: 30,
      errorBuilder: (context, error, stackTrace) => Icon(
        Icons.person_outline, // Fallback icon
        size: 30,
        color: Colors.grey,
      ),
    );
  }
}
