import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pickpay/core/utils/app_text_styles.dart';

class InfoSectionWithIcons extends StatelessWidget {
  const InfoSectionWithIcons({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'All prices include VAT.',
          style: TextStyles.bold13,
        ),
        SizedBox(height: 4),
        RichText(
          text: TextSpan(
            text: 'Buy with installments and pay ',
            style: TextStyles.bold13.copyWith(color: Colors.black),
            children: [
              TextSpan(
                text: 'EGP 745.00 ',
                style: TextStyles.bold13.copyWith(color: Colors.red),
              ),
              TextSpan(
                text: 'for 48 months with select banks. ',
                style: TextStyles.bold13.copyWith(color: Colors.black),
              ),
              TextSpan(
                text: 'Learn more',
                style: TextStyles.bold13.copyWith(color: Colors.blue),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    // Handle "Learn more" tap
                  },
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        const InfoIconsRow(),
      ],
    );
  }
}

class InfoIconsRow extends StatelessWidget {
  const InfoIconsRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: const [
        _InfoItem(
          icon: Icons.money,
          label: 'Cash on\ndelivery',
        ),
        _InfoItem(
          icon: Icons.refresh,
          label: '15 days\nrefundable',
        ),
        _InfoItem(
          icon: Icons.local_shipping,
          label: 'Free\ndelivery',
        ),
        _InfoItem(
          icon: Icons.lock,
          label: 'Secure\ntransaction',
        ),
      ],
    );
  }
}

class _InfoItem extends StatelessWidget {
  final IconData icon;
  final String label;

  const _InfoItem({
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 24,
          backgroundColor: Colors.grey.shade100,
          child: Icon(
            icon,
            color: const Color.fromARGB(156, 33, 149, 243),
            size: 24,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey.shade800,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
