// lib/features/sub_categories/pages/tvs_page.dart
import 'package:flutter/material.dart';

class Haircare extends StatelessWidget {
  const Haircare({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Haircare')),
      body: const Center(child: Text('Welcome to Haircare')),
    );
  }
}
