// lib/features/sub_categories/pages/tvs_page.dart
import 'package:flutter/material.dart';

class Men extends StatelessWidget {
  const Men({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Men's fashion")),
      body: const Center(child: Text("Men's fashion")),
    );
  }
}
