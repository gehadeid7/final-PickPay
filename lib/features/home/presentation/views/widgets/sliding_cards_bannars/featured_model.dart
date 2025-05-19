import 'package:flutter/material.dart';

class FeaturedItem {
  final String image;
  final String title;
  final String subtitle;
  final Widget? destinationView;
  final bool isCategories;

  // Make the constructor const
  const FeaturedItem({
    required this.image,
    required this.title,
    required this.subtitle,
    this.destinationView,
    required this.isCategories,
  });
}
