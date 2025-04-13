import 'package:flutter/material.dart';
import 'package:pickpay/core/widgets/custom_app.dart';
import 'package:pickpay/features/auth/presentation/views/widgets/sign_up_view_body.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  static const routeName = 'signup';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context: context, title: 'Sign Up'),
      body: SignUpViewBody(),
    );
  }
}
