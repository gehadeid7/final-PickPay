import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
              : [Colors.purple.shade50, Colors.white],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(32),
          topRight: Radius.circular(32),
        ),
        boxShadow: [
          BoxShadow(
            color: primaryColor.withOpacity(0.05),
            blurRadius: 24,
            offset: const Offset(0, -8),
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
        'Video Games'
      ],
    );
  }

  Widget _buildContactColumn(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Contact Us', theme),
        const SizedBox(height: 12),
        _buildContactRow(Icons.email_outlined, 'support@pickpay.com', context),
        const SizedBox(height: 12),
        _buildContactRow(Icons.phone_outlined, '+20 123 456 7890', context),
        const SizedBox(height: 12),
        _buildContactRow(Icons.location_on_outlined, 'Cairo, Egypt', context),
        // const SizedBox(height: 24),
        // _buildSectionTitle('Follow Us', theme),
        // const SizedBox(height: 12),
        // _buildSocialIcons(context),
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
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: Text(
                item,
                style:
                    theme.textTheme.bodySmall?.copyWith(color: theme.hintColor),
              ),
            ),
          ),
      ],
    );
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

  // Widget _buildSocialIcons(BuildContext context) {
  //   final theme = Theme.of(context);
  //   return Wrap(
  //     spacing: 12,
  //     children: [
  //       _buildSocialIcon(FontAwesomeIcons.facebookF, context),
  //       _buildSocialIcon(FontAwesomeIcons.twitter, context),
  //       _buildSocialIcon(FontAwesomeIcons.instagram, context),
  //       _buildSocialIcon(FontAwesomeIcons.linkedinIn, context),
  //     ],
  //   );
  // }

  Widget _buildSocialIcon(IconData icon, BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: theme.cardColor,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: IconButton(
        icon: FaIcon(icon, size: 16, color: theme.hintColor),
        onPressed: () {},
        padding: EdgeInsets.zero,
      ),
    );
  }

  Widget _buildHeartDivider(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        Expanded(
          child: Divider(
            color: theme.primaryColor.withOpacity(0.2),
            thickness: 1,
            endIndent: 16,
          ),
        ),
        Icon(Icons.favorite, color: theme.primaryColor, size: 20),
        Expanded(
          child: Divider(
            color: theme.primaryColor.withOpacity(0.2),
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

// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:flutter_animate/flutter_animate.dart';

// class FooterWidget extends StatelessWidget {
//   const FooterWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     final isDark = theme.brightness == Brightness.dark;
//     final primaryColor = theme.primaryColor;

//     return Container(
//       padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 24),
//       decoration: BoxDecoration(
//         color: isDark ? Colors.grey.shade900 : Colors.grey.shade50,
//         borderRadius: const BorderRadius.only(
//           topLeft: Radius.circular(32),
//           topRight: Radius.circular(32),
//         ),
//         boxShadow: [
//           BoxShadow(
//             color: primaryColor.withOpacity(isDark ? 0.12 : 0.06),
//             blurRadius: 24,
//             offset: const Offset(0, -6),
//           ),
//         ],
//       ),
//       child: Column(
//         children: [
//           LayoutBuilder(
//             builder: (context, constraints) {
//               return constraints.maxWidth < 600
//                   ? _buildMobileLayout(context)
//                   : _buildDesktopLayout(context);
//             },
//           ),
//           const SizedBox(height: 32),
//           _buildDivider(context),
//           const SizedBox(height: 24),
//           _buildBottomBar(context),
//         ],
//       ),
//     );
//   }

//   Widget _buildDesktopLayout(BuildContext context) {
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Expanded(flex: 2, child: _buildBrandColumn(context)),
//         const SizedBox(width: 48),
//         Expanded(child: _buildCategoryColumn(context)),
//         Expanded(child: _buildCompanyColumn(context)),
//         Expanded(flex: 2, child: _buildContactColumn(context)),
//       ],
//     );
//   }

//   Widget _buildMobileLayout(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         _buildBrandColumn(context),
//         const SizedBox(height: 32),
//         Wrap(
//           spacing: 32,
//           runSpacing: 32,
//           children: [
//             _buildCategoryColumn(context),
//             _buildCompanyColumn(context),
//             _buildContactColumn(context),
//           ],
//         ),
//       ],
//     );
//   }

//   Widget _buildBrandColumn(BuildContext context) {
//     final theme = Theme.of(context);
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Row(
//           children: [
//             const FlutterLogo(size: 40),
//             const SizedBox(width: 12),
//             Text(
//               'PickPay',
//               style: theme.textTheme.headlineSmall?.copyWith(
//                 fontWeight: FontWeight.bold,
//                 color: theme.primaryColor,
//               ),
//             ),
//           ],
//         ),
//         const SizedBox(height: 16),
//         Text(
//           'Elevating your shopping experience. Curated collections, trusted quality, and seamless service.',
//           style: theme.textTheme.bodyMedium?.copyWith(
//             color: theme.hintColor,
//             height: 1.6,
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildCategoryColumn(BuildContext context) {
//     return _buildLinkSection(
//       context,
//       'Shop',
//       [
//         'Electronics',
//         'Appliances',
//         'Home & Living',
//         'Fashion',
//         'Beauty',
//         'Video Games'
//       ],
//     );
//   }

//   Widget _buildCompanyColumn(BuildContext context) {
//     return _buildLinkSection(
//       context,
//       'Company',
//       ['About Us', 'Careers', 'Blog', 'Help Center'],
//     );
//   }

//   Widget _buildContactColumn(BuildContext context) {
//     final theme = Theme.of(context);

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         _buildSectionTitle('Contact Us', theme),
//         const SizedBox(height: 16),
//         _buildContactRow(Icons.email_outlined, 'support@pickpay.com', context),
//         const SizedBox(height: 12),
//         _buildContactRow(Icons.phone_outlined, '+20 123 456 7890', context),
//         const SizedBox(height: 12),
//         _buildContactRow(Icons.location_on_outlined, 'Cairo, Egypt', context),
//         const SizedBox(height: 24),
//         _buildSectionTitle('Follow Us', theme),
//         const SizedBox(height: 12),
//         _buildSocialIcons(context),
//       ],
//     );
//   }

//   Widget _buildDivider(BuildContext context) {
//     final theme = Theme.of(context);
//     return Row(
//       children: [
//         Expanded(
//           child: Divider(
//             color: theme.primaryColor.withOpacity(0.2),
//             thickness: 1,
//             endIndent: 16,
//           ),
//         ),
//         Icon(Icons.favorite, color: theme.primaryColor, size: 20)
//             .animate()
//             .scale(duration: 1000.ms, curve: Curves.easeInOut)
//             .then(delay: 300.ms)
//             .scaleXY(end: 1.1, duration: 500.ms),
//         Expanded(
//           child: Divider(
//             color: theme.primaryColor.withOpacity(0.2),
//             thickness: 1,
//             indent: 16,
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildBottomBar(BuildContext context) {
//     final theme = Theme.of(context);
//     return Center(
//       child: Text(
//         '© 2025 PickPay, Inc. All rights reserved.',
//         style: theme.textTheme.bodySmall?.copyWith(
//           color: theme.hintColor,
//         ),
//       ),
//     );
//   }

//   Widget _buildLinkSection(
//       BuildContext context, String title, List<String> items) {
//     final theme = Theme.of(context);
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         _buildSectionTitle(title, theme),
//         const SizedBox(height: 16),
//         for (var item in items)
//           Padding(
//             padding: const EdgeInsets.symmetric(vertical: 4),
//             child: MouseRegion(
//               cursor: SystemMouseCursors.click,
//               child: Text(
//                 item,
//                 style:
//                     theme.textTheme.bodySmall?.copyWith(color: theme.hintColor),
//               )
//                   .animate(
//                       onPlay: (controller) => controller.repeat(reverse: true))
//                   .fade(duration: 300.ms),
//             ),
//           ),
//       ],
//     );
//   }

//   Widget _buildSectionTitle(String text, ThemeData theme) {
//     return Text(
//       text,
//       style: theme.textTheme.titleMedium?.copyWith(
//         fontWeight: FontWeight.w600,
//         color: theme.primaryColor,
//       ),
//     );
//   }

//   Widget _buildContactRow(IconData icon, String text, BuildContext context) {
//     final theme = Theme.of(context);
//     return Row(
//       children: [
//         Icon(icon, size: 18, color: theme.hintColor),
//         const SizedBox(width: 12),
//         Text(
//           text,
//           style: theme.textTheme.bodySmall?.copyWith(
//             color: theme.hintColor,
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildSocialIcons(BuildContext context) {
//     final theme = Theme.of(context);

//     return Wrap(
//       spacing: 12,
//       children: [
//         _buildSocialIcon(FontAwesomeIcons.facebookF, context),
//         _buildSocialIcon(FontAwesomeIcons.twitter, context),
//         _buildSocialIcon(FontAwesomeIcons.instagram, context),
//         _buildSocialIcon(FontAwesomeIcons.linkedinIn, context),
//         _buildSocialIcon(FontAwesomeIcons.youtube, context),
//       ],
//     );
//   }

//   Widget _buildSocialIcon(IconData icon, BuildContext context) {
//     final theme = Theme.of(context);
//     return Container(
//       width: 36,
//       height: 36,
//       decoration: BoxDecoration(
//         color: theme.cardColor,
//         shape: BoxShape.circle,
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.04),
//             blurRadius: 8,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: IconButton(
//         icon: FaIcon(icon, size: 16, color: theme.hintColor),
//         onPressed: () {},
//         padding: EdgeInsets.zero,
//       ),
//     ).animate().scale(
//           duration: 300.ms,
//           begin: const Offset(1, 1),
//           end: const Offset(1.1, 1.1),
//           curve: Curves.easeOut,
//         );
//   }
// }
