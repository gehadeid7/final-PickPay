// lib/features/sub_categories/pages/tvs_page.dart
import 'package:flutter/material.dart';

class BathView extends StatelessWidget {
  const BathView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('TVs')),
      body: const Center(child: Text('Welcome to TVs')),
    );
  }
}
