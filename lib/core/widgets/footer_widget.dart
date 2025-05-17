import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FooterWidget extends StatelessWidget {
  const FooterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? Colors.grey[300] : Colors.grey[800];
    final iconColor = isDark ? Colors.white70 : Colors.grey[700];

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
      decoration: BoxDecoration(
        color: isDark ? Colors.grey[900] : Colors.grey[50],
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return constraints.maxWidth < 600
              ? _buildMobileLayout(context, textColor, iconColor)
              : _buildDesktopLayout(context, textColor, iconColor);
        },
      ),
    );
  }

  Widget _buildDesktopLayout(
      BuildContext context, Color? textColor, Color? iconColor) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(child: _buildCategoryColumn(context, textColor)),
            Expanded(child: _buildCompanyColumn(context, textColor)),
            Expanded(child: _buildContactColumn(iconColor, textColor)),
          ],
        ),
        const SizedBox(height: 32),
        _buildFooterBottom(iconColor, textColor),
      ],
    );
  }

  Widget _buildMobileLayout(
      BuildContext context, Color? textColor, Color? iconColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildCategoryColumn(context, textColor),
        const SizedBox(height: 24),
        _buildCompanyColumn(context, textColor),
        const SizedBox(height: 24),
        _buildContactColumn(iconColor, textColor),
        const SizedBox(height: 24),
        _buildFooterBottom(iconColor, textColor),
      ],
    );
  }

  Widget _buildFooterBottom(Color? iconColor, Color? textColor) {
    return Column(
      children: [
        _buildSocialIcons(iconColor),
        const SizedBox(height: 24),
        const Divider(),
        const SizedBox(height: 16),
        Text(
          '© 2025 PickPay, Inc. All rights reserved.',
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryColumn(BuildContext context, Color? textColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('Categories', textColor),
          const SizedBox(height: 8),
          _buildFooterItem('Electronics',
              () => _navigateTo(context, 'electronics_view'), textColor),
          _buildFooterItem('Appliances',
              () => _navigateTo(context, 'Appliances'), textColor),
          _buildFooterItem(
              'Home & Living', () => _navigateTo(context, 'Home'), textColor),
          _buildFooterItem(
              'Fashion', () => _navigateTo(context, 'Fashion'), textColor),
          _buildFooterItem(
              'Beauty', () => _navigateTo(context, 'Beauty'), textColor),
          _buildFooterItem(
              'Video Games', () => _navigateTo(context, 'Beauty'), textColor),
        ],
      ),
    );
  }

  Widget _buildCompanyColumn(BuildContext context, Color? textColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('Company', textColor),
          const SizedBox(height: 8),
          _buildFooterItem(
              'About Us', () => _navigateToAboutUs(context), textColor),
          _buildFooterItem(
              'Help & Support', () => _navigateToBlog(context), textColor),
        ],
      ),
    );
  }

  Widget _buildContactColumn(Color? iconColor, Color? textColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('Contact Us', textColor),
          const SizedBox(height: 8),
          _buildContactRow(
              Icons.email, 'help@pickpay.com', iconColor, textColor),
          const SizedBox(height: 8),
          _buildContactRow(Icons.phone, '+20', iconColor, textColor),
          const SizedBox(height: 8),
          _buildContactRow(Icons.location_on, 'Egypt', iconColor, textColor),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String text, Color? color) {
    return Text(
      text,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 16,
        color: color,
      ),
    );
  }

  Widget _buildContactRow(
      IconData icon, String text, Color? iconColor, Color? textColor) {
    return Row(
      children: [
        Icon(icon, size: 16, color: iconColor),
        const SizedBox(width: 8),
        Text(text, style: TextStyle(fontSize: 13, color: textColor)),
      ],
    );
  }

  Widget _buildSocialIcons(Color? iconColor) {
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 16,
      children: [
        _buildSocialIcon(FontAwesomeIcons.facebook, iconColor),
        _buildSocialIcon(FontAwesomeIcons.twitter, iconColor),
        _buildSocialIcon(FontAwesomeIcons.instagram, iconColor),
        _buildSocialIcon(FontAwesomeIcons.linkedin, iconColor),
      ],
    );
  }

  Widget _buildSocialIcon(IconData icon, Color? color) {
    return IconButton(
      icon: FaIcon(icon, size: 20, color: color),
      onPressed: () {},
      padding: EdgeInsets.zero,
      constraints: const BoxConstraints(),
    );
  }

  Widget _buildFooterItem(String text, VoidCallback onTap, Color? color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: InkWell(
        onTap: onTap,
        hoverColor: Colors.transparent,
        splashColor: Colors.transparent,
        child: Text(
          text,
          style: TextStyle(
            fontSize: 14,
            color: color,
          ),
        ),
      ),
    );
  }

  void _navigateTo(BuildContext context, String category) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => Container(),
      ),
    );
  }

  void _navigateToAboutUs(BuildContext context) {}
  void _navigateToBlog(BuildContext context) {}
}
