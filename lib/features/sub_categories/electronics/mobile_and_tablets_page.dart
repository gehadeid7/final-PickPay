// lib/features/sub_categories/pages/mobile_and_tablets_page.dart
import 'package:flutter/material.dart';

class MobileAndTabletsPage extends StatelessWidget {
  const MobileAndTabletsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mobile & Tablets')),
      body: const Center(child: Text('Welcome to Mobile & Tablets')),
    );
  }
}
