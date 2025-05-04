import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pickpay/core/widgets/custom_app.dart';
import 'package:pickpay/features/auth/presentation/views/signin_view.dart';
import 'package:pickpay/features/home/presentation/views/cart_view.dart';

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
    return Scaffold(
      appBar: buildAppBar(context: context, title: 'Account'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // User Info Section
            Row(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: imageUrl.isNotEmpty
                      ? NetworkImage(imageUrl)
                      : const AssetImage('assets/user_placeholder.png')
                          as ImageProvider,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(fullName,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 4),
                      Text(email, style: const TextStyle(color: Colors.grey)),
                    ],
                  ),
                ),
                TextButton(onPressed: () {}, child: const Text("Edit")),
              ],
            ),
            const SizedBox(height: 24),

            // Quick Access
            _accountTile(Icons.shopping_bag, "My Orders", () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const CartView()),
              );
            }),
            _accountTile(Icons.favorite, "Wishlist", () {}),
            _accountTile(Icons.location_on, "Addresses", () {}),
            _accountTile(Icons.payment, "Payment Methods", () {}),
            const Divider(height: 32),

            // Settings Section
            _accountTile(Icons.lock, "Change Password", () {}),
            _accountTile(Icons.notifications, "Notifications", () {}),
            _accountTile(Icons.language, "Language", () {}),
            _accountTile(Icons.help_outline, "Help & Support", () {}),
            _accountTile(Icons.info_outline, "About Us", () {}),
            const Divider(height: 32),

            // Logout
            Center(
                child: ElevatedButton.icon(
              icon: const Icon(Icons.logout),
              label: const Text("Logout"),
              onPressed: () async {
                await FirebaseAuth.instance.signOut();

                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (_) => const SigninView()), // your login screen
                  (route) => false, // remove all previous routes
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                foregroundColor: Colors.white,
              ),
            ))
          ],
        ),
      ),
    );
  }

  Widget _accountTile(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.black87),
      title: Text(title),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }
}
