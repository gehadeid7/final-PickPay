// lib/features/sub_categories/pages/tvs_page.dart
import 'package:flutter/material.dart';

class Skincare extends StatelessWidget {
  const Skincare({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Skincare')),
      body: const Center(child: Text('Welcome to Skincare')),
    );
  }
}
