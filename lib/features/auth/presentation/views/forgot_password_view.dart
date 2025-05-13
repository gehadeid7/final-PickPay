import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:pickpay/core/services/get_it_service.dart';
import 'package:pickpay/core/utils/app_text_styles.dart';
import 'package:pickpay/core/widgets/build_appbar.dart';
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
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
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
            color: colorScheme.primary,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Enter your email to receive a password reset link',
          style: TextStyles.regular13.copyWith(
            color: colorScheme.onSurface.withOpacity(0.7),
          ),
        ),
        const SizedBox(height: 32),
        TextFormField(
          controller: _emailController,
          cursorColor: colorScheme.primary,
          autofocus: true,
          textInputAction: TextInputAction.done,
          autofillHints: const [AutofillHints.email],
          style: TextStyle(color: colorScheme.onSurface),
          decoration: InputDecoration(
            hintText: 'Email address',
            hintStyle: TextStyles.regular13.copyWith(
              color: colorScheme.onSurface.withOpacity(0.5),
            ),
            filled: true,
            fillColor: colorScheme.surfaceVariant,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: colorScheme.outline.withOpacity(0.5),
                width: 1.0,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: colorScheme.primary,
                width: 2.0,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: colorScheme.error,
                width: 1.0,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: colorScheme.error,
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
              backgroundColor: colorScheme.primary,
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
                : Text(
                    cooldown > 0 ? 'Resend in ${cooldown}s' : 'Send Reset link',
                    style: TextStyles.semiBold13.copyWith(
                      color: colorScheme.onPrimary,
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
                color: colorScheme.primary,
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'For security reasons, the reset link will expire in 1 hour',
          style: TextStyles.regular11.copyWith(
            color: colorScheme.onSurface.withOpacity(0.6),
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildSuccessUI() {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.check_circle, color: colorScheme.primary, size: 72),
        const SizedBox(height: 24),
        Text(
          'Email Sent!',
          style: TextStyles.bold23.copyWith(color: colorScheme.primary),
        ),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Text(
            'Check your inbox for the password reset link. If you don\'t see it, please check your spam folder.',
            textAlign: TextAlign.center,
            style: TextStyles.regular13.copyWith(
              color: colorScheme.onSurface.withOpacity(0.7),
            ),
          ),
        ),
        const SizedBox(height: 32),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: colorScheme.primary,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(
              'Return to Login',
              style: TextStyles.semiBold13.copyWith(
                color: colorScheme.onPrimary,
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _showFlushbar({
    required BuildContext context,
    required String message,
    required Color backgroundColor,
    required Color textColor,
    IconData? icon,
  }) {
    Flushbar(
      messageText: Text(
        message,
        style: TextStyles.regular13.copyWith(color: textColor),
      ),
      icon: icon != null ? Icon(icon, color: textColor) : null,
      backgroundColor: backgroundColor,
      duration: const Duration(seconds: 3),
      borderRadius: BorderRadius.circular(8),
      margin: const EdgeInsets.all(16),
      flushbarPosition: FlushbarPosition.TOP,
    ).show(context);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return BlocConsumer<ForgotPasswordCubit, ForgotPasswordState>(
      listener: (context, state) {
        if (state is ForgotPasswordSuccess) {
          _showFlushbar(
            context: context,
            message: 'Password reset email sent successfully',
            backgroundColor: colorScheme.primary,
            textColor: colorScheme.onPrimary,
            icon: Icons.check_circle,
          );
        } else if (state is ForgotPasswordFailure) {
          _showFlushbar(
            context: context,
            message: state.message,
            backgroundColor: colorScheme.error,
            textColor: colorScheme.onError,
            icon: Icons.error,
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
