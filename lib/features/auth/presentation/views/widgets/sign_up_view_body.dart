import 'package:flutter/material.dart';
import 'package:pickpay/constants.dart';
import 'package:pickpay/core/utils/app_images.dart';
import 'package:pickpay/core/widgets/custom_button.dart';
import 'package:pickpay/core/widgets/custom_text_field.dart';
import 'package:pickpay/features/auth/presentation/views/widgets/have_an_account.dart';
import 'package:pickpay/features/auth/presentation/views/widgets/terms_and_conditions.dart';

class SignUpViewBody extends StatelessWidget {
  const SignUpViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: KHorizontalPadding),
        child: Column(
          children: [
            SizedBox(height: 50),
            CustomTextFormField(
              hintText: 'Enter your first name',
              textInputType: TextInputType.name,
            ),
            SizedBox(height: 16),
            CustomTextFormField(
              hintText: 'Enter your last name',
              textInputType: TextInputType.name,
            ),
            SizedBox(height: 16),
            CustomTextFormField(
              hintText: 'Enter a valid email address',
              textInputType: TextInputType.emailAddress,
            ),
            SizedBox(height: 16),
            CustomTextFormField(
              suffixicon: Icon(Icons.remove_red_eye, color: Colors.grey),
              hintText: 'Enter a valid password',
              textInputType: TextInputType.visiblePassword,
            ),
            SizedBox(height: 16),
            TermsAndConditions(),
            SizedBox(height: 16),
            CustomButton(onPressed: () {}, buttonText: 'Create account'),
            SizedBox(height: 16),
            HaveAnAccount(),
          ],
        ),
      ),
    );
  }
}
