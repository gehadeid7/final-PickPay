import 'package:flutter/material.dart';
import 'package:pickpay/constants.dart';
import 'package:pickpay/core/utils/app_colors.dart';
import 'package:pickpay/core/utils/app_images.dart';
import 'package:pickpay/core/utils/app_text_styles.dart';
import 'package:pickpay/core/widgets/custom_button.dart';
import 'package:pickpay/core/widgets/custom_text_field.dart';
import 'package:pickpay/features/auth/presentation/views/widgets/dont_have_an_account.dart';
import 'package:pickpay/features/auth/presentation/views/widgets/or_divider.dart';
import 'package:pickpay/features/auth/presentation/views/widgets/social_login_button.dart';

class LoginViewBody extends StatelessWidget {
  const LoginViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: KHorizontalPadding),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 16),
              Image.asset(Assets.signinImage, height: 200, fit: BoxFit.contain),
              SizedBox(height: 24),

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

              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Forget Password?',
                    style: TextStyles.semiBold13.copyWith(
                      color: AppColors.primaryColor.withOpacity(0.7),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              CustomButton(onPressed: () {}, buttonText: 'Login'),
              SizedBox(height: 16),

              DontHaveAccount(),
              SizedBox(height: 20),
              OrDivider(),

              SocialLoginButton(
                onPressed: () {},
                socialButtonIconImage: Assets.googleIcon,
                socialButtonTitle: 'Sign in with Google',
              ),
              SizedBox(height: 10),
              SocialLoginButton(
                onPressed: () {},
                socialButtonIconImage: Assets.facebookIcon,
                socialButtonTitle: 'Sign in with facebook',
              ),
              SizedBox(height: 10),
              SocialLoginButton(
                onPressed: () {},
                socialButtonIconImage: Assets.appleIcon,
                socialButtonTitle: 'Sign in with Apple',
              ),
            ],
          ),
        ),
      ),
    );
  }
}


