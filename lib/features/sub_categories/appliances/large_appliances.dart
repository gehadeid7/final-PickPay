// lib/features/sub_categories/pages/laptop_page.dart
import 'package:flutter/material.dart';

class LargeAppliances extends StatelessWidget {
  const LargeAppliances({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Large Appliances')),
      body: const Center(child: Text('Welcome to LargeAppliances')),
    );
  }
}
