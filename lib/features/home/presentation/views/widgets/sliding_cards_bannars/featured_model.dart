import 'package:flutter/material.dart';

class FeaturedItem {
  final String image;
  final String title;
  final String subtitle;
  final Widget destinationView;

  FeaturedItem({
    required this.image,
    required this.title,
    required this.subtitle,
    required this.destinationView,
  });
}
