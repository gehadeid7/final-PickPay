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
  late String email, password;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: khorizontalPadding),
      child: SingleChildScrollView(
        child: Form(
          key: formKey,
          autovalidateMode: autovalidateMode,
          child: Column(
            children: [
              // Text('Welcome Back!',
              //     style: TextStyles.bold16.copyWith(
              //       fontSize: 24,
              //     )),
              SizedBox(height: 50),
              CustomTextFormField(
                onSaved: (value) {
                  email = value!;
                },
                hintText: 'Enter a valid email address',
                textInputType: TextInputType.emailAddress,
              ),
              SizedBox(height: 16),
              PasswordField(
                onSaved: (value) {
                  password = value!;
                },
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
              CustomButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      formKey.currentState!.save();

                      context.read<SigninCubit>().signin(email, password);
                    } else {
                      autovalidateMode = AutovalidateMode.always;
                      setState(() {});
                    }
                  },
                  buttonText: 'Log In'),
              SizedBox(height: 20),
              OrDivider(),
              SizedBox(height: 24),
              SocialLoginButton(
                onPressed: () {
                  context.read<SigninCubit>().signInWithGoogle();
                },
                socialButtonIconImage: Assets.googleIcon,
                socialButtonTitle: 'Sign in with Google',
              ),
              SizedBox(height: 10),
              SocialLoginButton(
                onPressed: () {
                  context.read<SigninCubit>().signInWithFacebook();
                },
                socialButtonIconImage: Assets.facebookIcon,
                socialButtonTitle: 'Sign in with facebook',
              ),
              SizedBox(height: 24),
              DontHaveAccount(),
            ],
          ),
        ),
      ),
    );
  }
}
