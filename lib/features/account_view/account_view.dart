import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pickpay/features/account_view/account_view_body.dart';

class AccountView extends StatelessWidget {
  static const routeName = 'Account_View';

  const AccountView({Key? key}) : super(key: key);

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
