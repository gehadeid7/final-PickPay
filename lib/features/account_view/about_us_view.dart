import 'package:flutter/material.dart';
import 'package:pickpay/core/utils/app_images.dart';
import 'package:pickpay/core/widgets/build_appbar.dart';

class AboutUsView extends StatelessWidget {
  const AboutUsView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: buildAppBar(context: context, title: 'About Us'),
      backgroundColor: isDarkMode ? const Color(0xFF121212) : Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Align(
              alignment: const Alignment(-0.2, 0),
              child: Image.asset(
                Assets.appLogo,
                height: 120,
                width: 120,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'PickPay',
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 32),
            _buildSection(
              title: 'Our Story',
              content:
                  'Founded in 2025, PickPay was created with the vision to revolutionize online shopping with seamless payment solutions. Our team of experts is dedicated to providing the best e-commerce experience.',
              context: context,
            ),
            _buildSection(
              title: 'Our Mission',
              content:
                  'To empower businesses and consumers with innovative payment solutions that are secure, fast, and easy to use, while maintaining the highest standards of customer service.',
              context: context,
            ),
            const SizedBox(height: 24),
            Text(
              '© 2023 PickPay. All rights reserved.',
              style: theme.textTheme.bodySmall?.copyWith(
                color: isDarkMode ? Colors.grey[500] : Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required String content,
    required BuildContext context,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            content,
            style: TextStyle(
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.grey[400]
                  : Colors.grey[700],
            ),
          ),
        ],
      ),
    );
  }
}
