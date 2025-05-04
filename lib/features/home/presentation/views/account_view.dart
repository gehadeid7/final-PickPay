import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pickpay/features/home/presentation/views/widgets/account_view_body.dart';

class AccountView extends StatelessWidget {
  const AccountView({super.key});

  static const routeName = 'Account_View';

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return AccountViewBody(
      fullName: user?.displayName ?? "No Name",
      email: user?.email ?? "No Email",
      imageUrl: user?.photoURL ?? "",
    );
  }
}
