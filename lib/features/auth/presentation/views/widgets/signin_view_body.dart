import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pickpay/animation/animated_form_field.dart';
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
import 'package:pickpay/main.dart';

class AnimatedBackground extends StatefulWidget {
  final Widget child;
  final Color primaryColor;

  const AnimatedBackground({
    super.key,
    required this.child,
    required this.primaryColor,
  });

  @override
  State<AnimatedBackground> createState() => _AnimatedBackgroundState();
}

class _AnimatedBackgroundState extends State<AnimatedBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat(reverse: true);
    _animation = Tween<double>(begin: 0, end: 100).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, _) {
        return CustomPaint(
          painter: _BackgroundPainter(widget.primaryColor, _animation.value),
          child: widget.child,
        );
      },
    );
  }
}

class _BackgroundPainter extends CustomPainter {
  final Color color;
  final double offset;

  _BackgroundPainter(this.color, this.offset);

  @override
  void paint(Canvas canvas, Size size) {
    // ignore: deprecated_member_use
    final paint = Paint()..color = color.withOpacity(0.1);

    canvas.drawCircle(
        Offset(size.width * 0.3, size.height * 0.3 + offset), 60, paint);
    canvas.drawCircle(
        Offset(size.width * 0.7, size.height * 0.5 - offset), 100, paint);
    canvas.drawCircle(
        Offset(size.width * 0.5, size.height * 0.8 + offset / 2), 80, paint);
  }

  @override
  bool shouldRepaint(covariant _BackgroundPainter oldDelegate) {
    return oldDelegate.offset != offset || oldDelegate.color != color;
  }
}

class SigninViewBody extends StatefulWidget {
  const SigninViewBody({super.key});

  @override
  State<SigninViewBody> createState() => _SigninViewBodyState();
}

class _SigninViewBodyState extends State<SigninViewBody>
    with TickerProviderStateMixin, RouteAware {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late AnimationController _animationController;
  late AnimationController _shakeController;
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;
  String _email = '', _password = '';

  // For button scale animation on tap
  double _buttonScale = 1.0;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..forward();

    _shakeController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    _animationController.dispose();
    _shakeController.dispose();
    super.dispose();
  }

  @override
  void didPush() {
    _resetAnimations();
  }

  @override
  void didPopNext() {
    _resetAnimations();
  }

  void _resetAnimations() {
    _animationController.reset();
    _animationController.forward();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      context.read<SigninCubit>().signin(_email, _password);
    } else {
      setState(() => _autovalidateMode = AutovalidateMode.always);
      _shakeController.forward(from: 0);
    }
  }

  Offset _getShakeOffset(double animationValue) {
    return Offset(
      animationValue * 4 * (0.5 - (animationValue - 0.25).abs()),
      0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBackground(
      primaryColor: AppColors.primaryColor,
      child: AnimatedBuilder(
        animation: _shakeController,
        builder: (context, child) {
          final offset = _getShakeOffset(_shakeController.value);
          return Transform.translate(
            offset: offset,
            child: child,
          );
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: khorizontalPadding),
          child: Form(
            key: _formKey,
            autovalidateMode: _autovalidateMode,
            child: Column(
              children: [
                const SizedBox(height: 50),
                AnimatedFormField(
                  animation: _animationController,
                  delay: 0.1,
                  child: CustomTextFormField(
                    onSaved: (value) => _email = value!,
                    hintText: 'Enter a valid email address',
                    textInputType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                          .hasMatch(value)) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 16),
                AnimatedFormField(
                  animation: _animationController,
                  delay: 0.2,
                  child: PasswordField(
                    onSaved: (value) => _password = value!,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      if (value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 16),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () => Navigator.pushNamed(
                        context, ForgotPasswordView.routeName),
                    child: Text(
                      'Forgot Password?',
                      style: TextStyles.semiBold13.copyWith(
                        // ignore: deprecated_member_use
                        color: AppColors.primaryColor.withOpacity(0.7),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                BlocBuilder<SigninCubit, SigninState>(
                  builder: (context, state) {
                    return AnimatedFormField(
                      animation: _animationController,
                      delay: 0.3,
                      child: GestureDetector(
                        onTapDown: state is SigninLoading
                            ? null
                            : (_) => setState(() => _buttonScale = 0.95),
                        onTapUp: state is SigninLoading
                            ? null
                            : (_) {
                                setState(() => _buttonScale = 1.0);
                                _submit();
                              },
                        onTapCancel: () => setState(() => _buttonScale = 1.0),
                        child: Transform.scale(
                          scale: _buttonScale,
                          child: CustomButton(
                            onPressed: state is SigninLoading ? null : _submit,
                            buttonText: 'Log In',
                            isLoading: state is SigninLoading,
                          ),
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 20),
                AnimatedFormField(
                  animation: _animationController,
                  delay: 0.4,
                  child: const OrDivider(),
                ),
                const SizedBox(height: 24),
                AnimatedFormField(
                  animation: _animationController,
                  delay: 0.5,
                  child: SocialLoginButton(
                    onPressed: () =>
                        context.read<SigninCubit>().signInWithGoogle(),
                    socialButtonIconImage: Assets.googleIcon,
                    socialButtonTitle: 'Sign in with Google',
                  ),
                ),
                const SizedBox(height: 10),
                AnimatedFormField(
                  animation: _animationController,
                  delay: 0.6,
                  child: SocialLoginButton(
                    onPressed: () =>
                        context.read<SigninCubit>().signInWithFacebook(),
                    socialButtonIconImage: Assets.facebookIcon,
                    socialButtonTitle: 'Sign in with Facebook',
                  ),
                ),
                const SizedBox(height: 24),
                AnimatedFormField(
                  animation: _animationController,
                  delay: 0.7,
                  child: const Center(child: DontHaveAccount()),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
