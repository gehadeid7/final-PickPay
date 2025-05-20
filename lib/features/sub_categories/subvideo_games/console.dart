// lib/features/sub_categories/pages/tvs_page.dart
import 'package:flutter/material.dart';

class Console extends StatelessWidget {
  const Console({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Consoles')),
      body: const Center(child: Text('Welcome to Console')),
    );
  }
}
