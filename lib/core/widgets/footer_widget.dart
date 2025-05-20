import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pickpay/features/categories_pages/appliances/presentation/views/appliances_view.dart';
import 'package:pickpay/features/categories_pages/beauty/presentation/views/beauty_view.dart';
import 'package:pickpay/features/categories_pages/electronics/presentation/views/electronics_view.dart';
import 'package:pickpay/features/categories_pages/fashion/presentation/views/fashion_view.dart';
import 'package:pickpay/features/categories_pages/homeCategory/presentation/views/home_category_view.dart';
import 'package:pickpay/features/categories_pages/videogames/presentation/views/videogames_view.dart';

class FooterWidget extends StatelessWidget {
  const FooterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final primaryColor = theme.primaryColor;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isDark
              ? [Colors.grey.shade900, Colors.black]
              : [Colors.blue.shade50, Colors.white],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(32),
          topRight: Radius.circular(32),
        ),
        boxShadow: [
          BoxShadow(
            color: primaryColor,
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Column(
        children: [
          LayoutBuilder(
            builder: (context, constraints) {
              return constraints.maxWidth < 600
                  ? _buildMobileLayout(context)
                  : _buildDesktopLayout(context);
            },
          ),
          const SizedBox(height: 32),
          _buildHeartDivider(context),
          const SizedBox(height: 24),
          _buildBottomBar(context),
        ],
      ),
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: _buildCategoryColumn(context)),
        Expanded(flex: 2, child: _buildContactColumn(context)),
      ],
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildCategoryColumn(context),
        const SizedBox(height: 32),
        _buildContactColumn(context),
      ],
    );
  }

  Widget _buildCategoryColumn(BuildContext context) {
    return _buildLinkSection(
      context,
      'Shop',
      [
        'Electronics',
        'Appliances',
        'Home & Living',
        'Fashion',
        'Beauty',
        'Video Games',
      ],
    );
  }

  Widget _buildContactColumn(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Contact Us', Theme.of(context)),
        const SizedBox(height: 12),
        _buildContactRow(Icons.email_outlined, 'pickpay@gmail.com', context),
        const SizedBox(height: 12),
        _buildContactRow(Icons.phone_outlined, '+20 1066807592', context),
        const SizedBox(height: 12),
        _buildContactRow(Icons.location_on_outlined, 'Cairo, Egypt', context),
        const SizedBox(height: 24),
        _buildSectionTitle('Follow Us', Theme.of(context)),
        const SizedBox(height: 12),
        _buildSocialIcons(context),
      ],
    );
  }

  Widget _buildLinkSection(
      BuildContext context, String title, List<String> items) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(title, theme),
        const SizedBox(height: 16),
        for (var item in items)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: InkWell(
              onTap: () => _navigateToCategory(context, item),
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: Text(
                  item,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.hintColor,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }

  void _navigateToCategory(BuildContext context, String category) {
    switch (category) {
      case 'Electronics':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const ElectronicsView()),
        );
        break;
      case 'Appliances':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const AppliancesView()),
        );
        break;
      case 'Home & Living':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => HomeCategoryView()),
        );
        break;
      case 'Fashion':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const FashionView()),
        );
        break;
      case 'Beauty':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const BeautyView()),
        );
        break;
      case 'Video Games':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => VideogamesView()),
        );
        break;
    }
  }

  Widget _buildSectionTitle(String text, ThemeData theme) {
    return Text(
      text,
      style: theme.textTheme.titleMedium?.copyWith(
        fontWeight: FontWeight.w600,
        color: theme.primaryColor,
      ),
    );
  }

  Widget _buildContactRow(IconData icon, String text, BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        Icon(icon, size: 18, color: theme.hintColor),
        const SizedBox(width: 12),
        Text(
          text,
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.hintColor,
          ),
        ),
      ],
    );
  }

  Widget _buildSocialIcons(BuildContext context) {
    return Wrap(
      spacing: 12,
      children: [
        _buildSocialIcon(FontAwesomeIcons.facebookF, context),
      ],
    );
  }

  Widget _buildSocialIcon(IconData icon, BuildContext context) {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: Colors.blue,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(103, 128, 118, 118),
            blurRadius: 2,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: IconButton(
        icon: FaIcon(icon, size: 16),
        onPressed: () {},
        color: Colors.white,
      ),
    );
  }

  Widget _buildHeartDivider(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        Expanded(
          child: Divider(
            color: theme.primaryColor,
            thickness: 1,
            endIndent: 16,
          ),
        ),
        Icon(Icons.favorite, color: theme.primaryColor, size: 20),
        Expanded(
          child: Divider(
            color: theme.primaryColor,
            thickness: 1,
            indent: 16,
          ),
        ),
      ],
    );
  }

  Widget _buildBottomBar(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Text(
        '© 2025 PickPay. All rights reserved.',
        style: theme.textTheme.bodySmall?.copyWith(
          color: theme.hintColor,
        ),
      ),
    );
  }
}
