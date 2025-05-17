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
        extendBodyBehindAppBar: true,
        appBar: buildAppBar(
            context: context,
            title: 'Forgot Password',
            elevation: 0,
            backgroundColor: Colors.transparent),
        body: Stack(
          children: [
            const AnimatedBackground(),
            const ForgotPasswordForm(),
          ],
        ),
      ),
    );
  }
}

class AnimatedBackground extends StatefulWidget {
  const AnimatedBackground({Key? key}) : super(key: key);

  @override
  State<AnimatedBackground> createState() => _AnimatedBackgroundState();
}

class _AnimatedBackgroundState extends State<AnimatedBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _colorAnimation1;
  late Animation<Color?> _colorAnimation2;

  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 10))
          ..repeat(reverse: true);

    _colorAnimation1 = ColorTween(
      begin: Colors.blue.shade700,
      end: Colors.blue.shade300,
    ).animate(_controller);

    _colorAnimation2 = ColorTween(
      begin: Colors.purple.shade700,
      end: Colors.purple.shade300,
    ).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [_colorAnimation1.value!, _colorAnimation2.value!],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        );
      },
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
    // ignore: unnecessary_cast
    final cooldown = isSuccess ? (state as ForgotPasswordSuccess).cooldown : 0;
    final isLoading = state is ForgotPasswordLoading;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 120),
        Text(
          'Forgot Password?',
          style: TextStyles.bold16.copyWith(
            fontSize: 28,
            color: Colors.white,
            shadows: [
              Shadow(
                blurRadius: 6,
                color: Colors.black38,
                offset: Offset(0, 2),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'Enter your email to receive a password reset link',
          style: TextStyles.regular13.copyWith(
            color: Colors.white70,
            shadows: [
              Shadow(
                blurRadius: 4,
                color: Colors.black26,
                offset: Offset(0, 1),
              ),
            ],
          ),
        ),
        const SizedBox(height: 40),
        TextFormField(
          controller: _emailController,
          cursorColor: Colors.white,
          autofocus: true,
          textInputAction: TextInputAction.done,
          autofillHints: const [AutofillHints.email],
          style: const TextStyle(color: Colors.white),
          enabled: !isLoading,
          decoration: InputDecoration(
            hintText: 'Email address',
            hintStyle: TextStyles.regular13.copyWith(
              // ignore: deprecated_member_use
              color: Colors.white70.withOpacity(0.7),
            ),
            filled: true,
            fillColor: Colors.white24,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: Colors.white38,
                width: 1.2,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: Colors.white,
                width: 2,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: colorScheme.error,
                width: 1.5,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: colorScheme.error,
                width: 2,
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
        const SizedBox(height: 32),
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
              backgroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 18),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 4,
            ),
            child: isLoading
                ? const SizedBox(
                    width: 22,
                    height: 22,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.blueAccent,
                    ),
                  )
                : Text(
                    cooldown > 0 ? 'Resend in ${cooldown}s' : 'Send Reset Link',
                    style: TextStyles.semiBold13.copyWith(
                      color: Colors.blue.shade700,
                    ),
                  ),
          ),
        ),
        const SizedBox(height: 20),
        Center(
          child: TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Back to Sign In',
              style: TextStyles.semiBold13.copyWith(
                color: Colors.white,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'For security reasons, the reset link will expire in 1 hour',
          style: TextStyles.regular11.copyWith(
            color: Colors.white70,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 30),
      ],
    );
  }

  Widget _buildSuccessUI() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.check_circle, color: Colors.white, size: 80),
          const SizedBox(height: 24),
          Text(
            'Email Sent!',
            style: TextStyles.bold23.copyWith(
              color: Colors.white,
              shadows: [
                Shadow(
                  blurRadius: 6,
                  color: Colors.black45,
                  offset: Offset(0, 2),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 36),
            child: Text(
              'Check your inbox for the password reset link. If you don\'t see it, please check your spam folder.',
              textAlign: TextAlign.center,
              style: TextStyles.regular13.copyWith(
                color: Colors.white70,
              ),
            ),
          ),
          const SizedBox(height: 36),
          SizedBox(
            width: 180,
            child: ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 4,
              ),
              child: Text(
                'Return to Login',
                style: TextStyles.semiBold13.copyWith(
                  color: Colors.blue.shade700,
                ),
              ),
            ),
          ),
        ],
      ),
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
        if (state is ForgotPasswordLinkSent) {
          _showFlushbar(
            context: context,
            message: 'Password reset email sent successfully',
            backgroundColor: Colors.green.shade600,
            textColor: Colors.white,
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
                  duration: const Duration(milliseconds: 400),
                  switchInCurve: Curves.easeInOut,
                  switchOutCurve: Curves.easeInOut,
                  child: state is ForgotPasswordLinkSent
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
