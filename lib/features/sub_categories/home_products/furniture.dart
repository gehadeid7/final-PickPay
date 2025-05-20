// lib/features/sub_categories/pages/laptop_page.dart
import 'package:flutter/material.dart';

class FurnitureView extends StatelessWidget {
  const FurnitureView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Laptop')),
      body: const Center(child: Text('Welcome to Laptop')),
    );
  }
}
