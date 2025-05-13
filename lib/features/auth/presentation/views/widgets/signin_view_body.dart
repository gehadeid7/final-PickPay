import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pickpay/constants.dart';
import 'package:pickpay/core/utils/app_colors.dart';
import 'package:pickpay/core/utils/app_images.dart';
import 'package:pickpay/core/utils/app_text_styles.dart';
import 'package:pickpay/core/widgets/custom_button.dart';
import 'package:pickpay/core/widgets/custom_text_field.dart';
import 'package:pickpay/core/widgets/password_field.dart';
import 'package:pickpay/features/auth/presentation/cubits/signin_cubit/signin_cubit.dart';
import 'package:pickpay/features/auth/presentation/views/forgot_password_view.dart';
import 'package:pickpay/features/auth/presentation/views/widgets/dont_have_an_account.dart';
import 'package:pickpay/features/auth/presentation/views/widgets/or_divider.dart';
import 'package:pickpay/features/auth/presentation/views/widgets/social_login_button.dart';

class SigninViewBody extends StatefulWidget {
  const SigninViewBody({super.key});

  @override
  State<SigninViewBody> createState() => _SigninViewBodyState();
}

class _SigninViewBodyState extends State<SigninViewBody> {
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late String email, password;

  void _submit() {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      context.read<SigninCubit>().signin(email, password);
    } else {
      setState(() {
        autovalidateMode = AutovalidateMode.always;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: khorizontalPadding),
      child: SingleChildScrollView(
        child: Form(
          key: formKey,
          autovalidateMode: autovalidateMode,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 50),
              CustomTextFormField(
                onSaved: (value) => email = value!,
                hintText: 'Enter a valid email address',
                textInputType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16),
              PasswordField(
                onSaved: (value) => password = value!,
              ),
              const SizedBox(height: 16),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, ForgotPasswordView.routeName);
                  },
                  child: Text(
                    'Forget Password?',
                    style: TextStyles.semiBold13.copyWith(
                      color: AppColors.primaryColor.withOpacity(0.7),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              CustomButton(
                onPressed: _submit,
                buttonText: 'Log In',
              ),
              const SizedBox(height: 20),
              const OrDivider(),
              const SizedBox(height: 24),
              SocialLoginButton(
                onPressed: () {
                  context.read<SigninCubit>().signInWithGoogle();
                },
                socialButtonIconImage: Assets.googleIcon,
                socialButtonTitle: 'Sign in with Google',
              ),
              const SizedBox(height: 10),
              SocialLoginButton(
                onPressed: () {
                  context.read<SigninCubit>().signInWithFacebook();
                },
                socialButtonIconImage: Assets.facebookIcon,
                socialButtonTitle: 'Sign in with Facebook',
              ),
              const SizedBox(height: 24),
              const DontHaveAccount(),
            ],
          ),
        ),
      ),
    );
  }
}
