import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pickpay/core/utils/app_text_styles.dart';

class InfoSectionWithIcons extends StatelessWidget {
  const InfoSectionWithIcons({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDarkMode = theme.brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'All prices include VAT.',
          style: TextStyles.bold13.copyWith(
            color: isDarkMode ? colorScheme.onSurface : Colors.black,
          ),
        ),
        const SizedBox(height: 4),
        RichText(
          text: TextSpan(
            text: 'Buy with installments and pay ',
            style: TextStyles.bold13.copyWith(
              color: isDarkMode ? colorScheme.onSurface : Colors.black,
            ),
            children: [
              TextSpan(
                text: 'EGP 745.00 ',
                style: TextStyles.bold13.copyWith(color: Colors.red),
              ),
              TextSpan(
                text: 'for 48 months with select banks. ',
                style: TextStyles.bold13.copyWith(
                  color: isDarkMode ? colorScheme.onSurface : Colors.black,
                ),
              ),
              TextSpan(
                text: 'Learn more',
                style: TextStyles.bold13.copyWith(
                  color: colorScheme.primary,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    // Handle "Learn more" tap
                  },
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        InfoIconsRow(isDarkMode: isDarkMode),
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
    // ignore: unused_local_variable
    final colorScheme = theme.colorScheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _InfoItem(
          icon: Icons.money,
          label: 'Cash on\ndelivery',
          isDarkMode: isDarkMode,
        ),
        _InfoItem(
          icon: Icons.refresh,
          label: '15 days\nrefundable',
          isDarkMode: isDarkMode,
        ),
        _InfoItem(
          icon: Icons.local_shipping,
          label: 'Free\ndelivery',
          isDarkMode: isDarkMode,
        ),
        _InfoItem(
          icon: Icons.lock,
          label: 'Secure\ntransaction',
          isDarkMode: isDarkMode,
        ),
      ],
    );
  }
}

class _InfoItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isDarkMode;

  const _InfoItem({
    required this.icon,
    required this.label,
    required this.isDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      children: [
        CircleAvatar(
          radius: 24,
          backgroundColor:
              // ignore: deprecated_member_use
              isDarkMode ? colorScheme.surfaceVariant : Colors.grey.shade100,
          child: Icon(
            icon,
            color: colorScheme.primary,
            size: 24,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: isDarkMode
                // ignore: deprecated_member_use
                ? colorScheme.onSurface.withOpacity(0.8)
                : Colors.grey.shade800,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
