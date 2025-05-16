import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pickpay/core/services/get_it_service.dart'; // make sure to import getIt here
import 'package:pickpay/core/utils/app_images.dart';
import 'package:pickpay/core/widgets/build_appbar.dart';
import 'package:pickpay/features/auth/domain/repos/auth_repo.dart';
import 'package:pickpay/features/auth/presentation/views/change_password_view.dart';
import 'package:pickpay/features/auth/presentation/views/signin_view.dart';
import 'package:pickpay/features/home/presentation/views/cart_view.dart';
import 'package:pickpay/features/profile_change/views/profile_change_view.dart';
import 'package:pickpay/features/home/presentation/views/wishlist_view.dart';

class AccountViewBody extends StatelessWidget {
  final String fullName;
  final String email;
  final String imageUrl;

  
  const AccountViewBody({
    super.key,
    required this.fullName,
    required this.email,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    final authRepo = getIt<AuthRepo>();  // Inject AuthRepo here
    
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDarkMode ? Colors.grey[900] : Colors.white,
      appBar: buildAppBar(
        context: context,
        title: 'Account',
        onBackPressed: () {
          Navigator.pushNamed(context, '/main-navigation');
        },
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildUserInfoSection(context, authRepo),
            const SizedBox(height: 32),
            _buildSectionTitle('Quick Access', context),
            _buildSectionContainer([
              _accountTile(Icons.shopping_bag_outlined, "My Orders", () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const CartView()));
              }, context),
              _accountTile(Icons.favorite_border, "Wishlist", () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const WishlistView()));
              }, context),
            ], context),
            const SizedBox(height: 24),
            _buildSectionTitle('Settings', context),
            _buildSectionContainer([
              _accountTile(Icons.lock_outline, "Change Password", () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const ChangePasswordView()));
              }, context),
              _accountTile(Icons.language_outlined, "Language", () {}, context),
              _accountTile(Icons.help_outline, "Help & Support", () {}, context),
              _accountTile(Icons.info_outline, "About Us", () {}, context),
            ], context),
            const SizedBox(height: 32),
            _buildLogoutButton(context),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildUserInfoSection(BuildContext context, AuthRepo authRepo) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProfileChangeView(
            ),
          ),
        );
      },
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isDarkMode ? Colors.grey[800] : Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(isDarkMode ? 0.1 : 0.05),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
          border: Border.all(
              color: isDarkMode ? Colors.grey[700]! : Colors.grey.shade100),
        ),
        child: Row(
          children: [
            _buildUserAvatar(context),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    fullName,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: isDarkMode ? Colors.white : Colors.black,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    email,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color:
                          isDarkMode ? Colors.grey[400] : Colors.grey.shade500,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfileChangeView(
                    ),
                  ),
                );
              },
              icon: Icon(Icons.edit_outlined,
                  color: isDarkMode ? Colors.white : Colors.black),
              splashRadius: 20,
            ),
          ],
        ),
      ),
    );
  }


  Widget _buildUserAvatar(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Container(
      width: 72,
      height: 72,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: (isDarkMode ? Colors.white : Colors.black).withOpacity(0.3),
          width: 2,
        ),
      ),
      child: ClipOval(child: _buildUserImage(context)),
    );
  }

  Widget _buildUserImage(BuildContext context) {
    if (imageUrl.isNotEmpty) {
      return Image.network(
        imageUrl,
        width: 72,
        height: 72,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) =>
            _buildPlaceholderIcon(context),
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Center(
            child: CircularProgressIndicator(
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded /
                      loadingProgress.expectedTotalBytes!
                  : null,
            ),
          );
        },
      );
    }
    return _buildPlaceholderAssetImage(context);
  }

  Widget _buildPlaceholderAssetImage(BuildContext context) {
    return Image.asset(
      Assets.appLogo,
      width: 72,
      height: 72,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) =>
          _buildPlaceholderIcon(context),
    );
  }

  Widget _buildPlaceholderIcon(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Container(
      color: isDarkMode ? Colors.grey[700] : Colors.grey.shade100,
      child: Icon(Icons.person,
          size: 36, color: isDarkMode ? Colors.grey[300] : Colors.grey),
    );
  }

  Widget _buildSectionTitle(String title, BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, bottom: 8),
      child: Text(
        title,
        style: theme.textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.w600,
          color:
              theme.brightness == Brightness.dark ? Colors.white : Colors.black,
        ),
      ),
    );
  }

  Widget _buildSectionContainer(List<Widget> children, BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.grey[800] : Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isDarkMode ? 0.1 : 0.03),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: children.asMap().entries.map((entry) {
          final index = entry.key;
          final child = entry.value;
          return Column(
            children: [
              child,
              if (index != children.length - 1)
                Divider(
                  height: 1,
                  color: isDarkMode ? Colors.grey[700]! : Colors.grey.shade300,
                ),
            ],
          );
        }).toList(),
      ),
    );
  }

  Widget _accountTile(
      IconData icon, String title, VoidCallback onTap, BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final iconColor = isDarkMode ? Colors.white : Colors.black;
    final textColor = isDarkMode ? Colors.white : Colors.black87;

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: iconColor.withOpacity(0.08),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, size: 20, color: iconColor),
      ),
      title: Text(
        title,
        style: TextStyle(fontSize: 15, color: textColor),
      ),
      trailing: Icon(Icons.chevron_right,
          color: isDarkMode ? Colors.grey[400] : Colors.grey.shade400),
      onTap: onTap,
      minLeadingWidth: 0,
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SizedBox(
        width: double.infinity,
        child: OutlinedButton.icon(
          icon: const Icon(Icons.logout, size: 20),
          label: const Text("Logout",
              style: TextStyle(fontWeight: FontWeight.w600)),
          onPressed: () => _confirmLogout(context),
          style: OutlinedButton.styleFrom(
            foregroundColor: Colors.red,
            side: const BorderSide(color: Colors.red),
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
      ),
    );
  }

  Future<void> _confirmLogout(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to log out?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const SigninView()),
                (route) => false,
              );
            },
            child: const Text('Logout'),
          ),
        ],
      ),
    );

    if (confirmed ?? false) {
      // no further action needed
    }
  }
}