// lib/features/sub_categories/pages/tvs_page.dart
import 'package:flutter/material.dart';

class Accessories extends StatelessWidget {
  const Accessories({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Accessories')),
      body: const Center(child: Text('Welcome to Accessories')),
    );
  }
}
