// lib/features/sub_categories/pages/laptop_page.dart
import 'package:flutter/material.dart';

class SmallAppliances extends StatelessWidget {
  const SmallAppliances({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Small Appliances')),
      body: const Center(child: Text('Welcome to Small Appliances')),
    );
  }
}
