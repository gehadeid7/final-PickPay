import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pickpay/core/services/get_it_service.dart';
import 'package:pickpay/core/utils/app_colors.dart';
import 'package:pickpay/core/utils/app_text_styles.dart';
import 'package:pickpay/core/widgets/custom_app.dart';
import 'package:pickpay/features/auth/domain/repos/auth_repo.dart';
import 'package:pickpay/features/auth/presentation/cubits/forgetpassword_cubit/forgot_password_cubit.dart';

class ForgotPasswordView extends StatelessWidget {
  const ForgotPasswordView({super.key});

  static const routeName = 'forgot-password';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ForgotPasswordCubit(getIt<AuthRepo>()),
      child: Scaffold(
        appBar: buildAppBar(context: context, title: 'Forgot Password'),
        body: const ForgotPasswordForm(),
      ),
    );
  }
}

class ForgotPasswordForm extends StatefulWidget {
  const ForgotPasswordForm({super.key});

  @override
  State<ForgotPasswordForm> createState() => _ForgotPasswordFormState();
}

class _ForgotPasswordFormState extends State<ForgotPasswordForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Widget _buildFormContent(BuildContext context, ForgotPasswordState state) {
    final isSuccess = state is ForgotPasswordSuccess;
    final cooldown = isSuccess ? (state as ForgotPasswordSuccess).cooldown : 0;
    final isLoading = state is ForgotPasswordLoading;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 40),
        Text(
          'Forgot Password?',
          style: TextStyles.bold16.copyWith(
            fontSize: 24,
            color: AppColors.primaryColor,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Enter your email to receive a password reset link',
          style: TextStyles.regular13.copyWith(
            color: AppColors.secondColor,
          ),
        ),
        const SizedBox(height: 32),
        TextFormField(
          controller: _emailController,
          cursorColor: AppColors.primaryColor,
          autofocus: true,
          textInputAction: TextInputAction.done,
          autofillHints: const [AutofillHints.email],
          decoration: InputDecoration(
            hintText: 'Enter your email address',
            hintStyle: TextStyles.regular13.copyWith(
              color: AppColors.secondColor.withOpacity(0.6),
            ),
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: AppColors.secondColor.withOpacity(0.3),
                width: 1.0,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: AppColors.primaryColor,
                width: 2.0,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: Colors.red,
                width: 1.0,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: Colors.red,
                width: 2.0,
              ),
            ),
          ),
          keyboardType: TextInputType.emailAddress,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your email';
            }
            if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
              return 'Please enter a valid email';
            }
            return null;
          },
        ),
        const SizedBox(height: 24),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: (cooldown > 0 || isLoading)
                ? null
                : () {
                    if (_formKey.currentState!.validate()) {
                      context
                          .read<ForgotPasswordCubit>()
                          .sendPasswordResetEmail(
                            _emailController.text.trim(),
                          );
                    } else {
                      setState(() {
                        _autovalidateMode = AutovalidateMode.always;
                      });
                    }
                  },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              elevation: 0,
            ),
            child: isLoading
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                : cooldown > 0
                    ? Text(
                        'Resend in ${cooldown}s',
                        style: TextStyles.semiBold13.copyWith(
                          color: Colors.white,
                        ),
                      )
                    : Text(
                        'Send Reset Link',
                        style: TextStyles.semiBold13.copyWith(
                          color: Colors.white,
                        ),
                      ),
          ),
        ),
        const SizedBox(height: 16),
        Center(
          child: TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Back to Sign In',
              style: TextStyles.semiBold13.copyWith(
                color: AppColors.primaryColor,
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'For security reasons, the reset link will expire in 1 hour',
          style: TextStyles.regular11.copyWith(
            color: AppColors.secondColor.withOpacity(0.6),
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildSuccessUI() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.check_circle,
          color: AppColors.primaryColor,
          size: 72,
        ),
        const SizedBox(height: 24),
        Text(
          'Email Sent!',
          style: TextStyles.bold23.copyWith(color: AppColors.primaryColor),
        ),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Text(
            'Check your inbox for the password reset link. If you don\'t see it, please check your spam folder.',
            textAlign: TextAlign.center,
            style: TextStyles.regular13.copyWith(
              color: AppColors.secondColor,
            ),
          ),
        ),
        const SizedBox(height: 32),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(
              'Return to Login',
              style: TextStyles.semiBold13.copyWith(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ForgotPasswordCubit, ForgotPasswordState>(
      listener: (context, state) {
        if (state is ForgotPasswordSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Password reset email sent successfully',
                style: TextStyles.regular11.copyWith(color: Colors.white),
              ),
              backgroundColor: AppColors.primaryColor,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          );
        } else if (state is ForgotPasswordFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.message,
                style: TextStyles.regular13.copyWith(color: Colors.white),
              ),
              backgroundColor: Colors.red,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          );
        }
      },
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: math.max(20, MediaQuery.of(context).size.width * 0.1),
          ),
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 400),
              child: Form(
                key: _formKey,
                autovalidateMode: _autovalidateMode,
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: state is ForgotPasswordSuccess
                      ? _buildSuccessUI()
                      : _buildFormContent(context, state),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
