import 'package:flutter/material.dart';
import 'package:pickpay/core/utils/app_text_styles.dart';

class InfoSectionWithIcons extends StatelessWidget {
  const InfoSectionWithIcons({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDarkMode = theme.brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.grey[900] : Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDarkMode ? Colors.grey[800]! : Colors.grey[200]!,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Price Information
          _buildPriceInfo(context, isDarkMode, colorScheme),

          const SizedBox(height: 5),

          // Installment Information
          _buildInstallmentInfo(context, isDarkMode, colorScheme),

          const SizedBox(height: 5),

          // Features Row
          InfoIconsRow(isDarkMode: isDarkMode),
        ],
      ),
    );
  }

  Widget _buildPriceInfo(
      BuildContext context, bool isDarkMode, ColorScheme colorScheme) {
    return Row(
      children: [
        Icon(
          Icons.verified_rounded,
          size: 18,
          color: Colors.green,
        ),
        const SizedBox(width: 8),
        Text(
          'All prices include VAT.',
          style: TextStyles.bold13.copyWith(
            color: isDarkMode ? colorScheme.onSurface : Colors.grey[800],
          ),
        ),
      ],
    );
  }

  Widget _buildInstallmentInfo(
      BuildContext context, bool isDarkMode, ColorScheme colorScheme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Flexible Payment Options',
          style: TextStyles.bold13.copyWith(
            color: isDarkMode ? colorScheme.onSurface : Colors.black,
          ),
        ),
        const SizedBox(height: 6),
        RichText(
          text: TextSpan(
            text: 'Buy with installments and pay ',
            style: TextStyles.regular13.copyWith(
              color: isDarkMode
                  // ignore: deprecated_member_use
                  ? colorScheme.onSurface.withOpacity(0.9)
                  : Colors.grey[800],
            ),
            children: [
              TextSpan(
                text: 'EGP 745.00 ',
                style: TextStyles.regular13.copyWith(
                  color: Colors.red[600],
                ),
              ),
              TextSpan(
                text: 'for 48 months with select banks. ',
                style: TextStyles.regular13.copyWith(
                  color: isDarkMode
                      // ignore: deprecated_member_use
                      ? colorScheme.onSurface.withOpacity(0.9)
                      : Colors.grey[800],
                ),
              ),
              // TextSpan(
              //   text: 'Learn more',
              //   style: TextStyles.semiBold13.copyWith(
              //     color: colorScheme.primary,
              //     decoration: TextDecoration.underline,
              //     decorationColor: colorScheme.primary.withOpacity(0.5),
              //   ),
              //   recognizer: TapGestureRecognizer()
              //     ..onTap = () {
              //       // Handle "Learn more" tap
              //     },
              // ),
            ],
          ),
        ),
      ],
    );
  }
}

class InfoIconsRow extends StatelessWidget {
  final bool isDarkMode;

  const InfoIconsRow({
    super.key,
    required this.isDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.grey[850] : Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: isDarkMode ? Colors.grey[700]! : Colors.grey[200]!,
          width: 1,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _InfoItem(
            icon: Icons.money_rounded,
            label: 'Cash on Delivery',
            color: Colors.green,
            isDarkMode: isDarkMode,
          ),
          _InfoItem(
            icon: Icons.refresh_rounded,
            label: '15-Day Returns',
            color: Colors.blue,
            isDarkMode: isDarkMode,
          ),
          _InfoItem(
            icon: Icons.local_shipping_rounded,
            label: 'Free Shipping',
            color: Colors.orange,
            isDarkMode: isDarkMode,
          ),
          _InfoItem(
            icon: Icons.lock_rounded,
            label: 'Secure Payment',
            color: Colors.purple,
            isDarkMode: isDarkMode,
          ),
        ],
      ),
    );
  }
}

class _InfoItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final bool isDarkMode;

  const _InfoItem({
    required this.icon,
    required this.label,
    required this.color,
    required this.isDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            // ignore: deprecated_member_use
            color: color.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: color,
            size: 22,
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          width: 80,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: isDarkMode ? Colors.grey[300] : Colors.grey[800],
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
          ),
        ),
      ],
    );
  }
}
