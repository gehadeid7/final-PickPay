import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pickpay/animation/animated_form_field.dart';
import 'package:pickpay/constants.dart';
import 'package:pickpay/core/widgets/custom_button.dart';
import 'package:pickpay/core/widgets/custom_text_field.dart';
import 'package:pickpay/core/widgets/password_field.dart';
import 'package:pickpay/features/auth/presentation/cubits/signup_cubits/signup_cubit.dart';
import 'package:pickpay/features/auth/presentation/views/widgets/have_an_account.dart';
import 'package:pickpay/features/auth/presentation/views/widgets/terms_and_conditions.dart';
import 'package:pickpay/main.dart';
import 'package:pickpay/core/utils/app_colors.dart';

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

class SignUpViewBody extends StatefulWidget {
  const SignUpViewBody({super.key});

  @override
  State<SignUpViewBody> createState() => _SignUpViewBodyState();
}

class _SignUpViewBodyState extends State<SignUpViewBody>
    with TickerProviderStateMixin, RouteAware {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late AnimationController _animationController;
  late AnimationController _shakeController;
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;
  late String _email, _fullName, _password;
  bool _isTermsAccepted = false;

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
      if (_isTermsAccepted) {
        context.read<SignupCubit>().createUserWithEmailAndPassword(
              _email,
              _password,
              _fullName,
            );
      } else {
        _shakeController.forward(from: 0);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please accept terms and conditions')),
        );
      }
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
                    onSaved: (value) => _fullName = value!,
                    hintText: 'Enter your full name',
                    textInputType: TextInputType.name,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your full name';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 16),
                AnimatedFormField(
                  animation: _animationController,
                  delay: 0.2,
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
                  delay: 0.3,
                  child: PasswordField(
                    onSaved: (value) => _password = value!,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      if (value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      if (!RegExp(r'[A-Z]').hasMatch(value)) {
                        return 'Password must contain at least one uppercase letter';
                      }
                      if (!RegExp(r'[!@#\$%^&*(),.?":{}|<>]').hasMatch(value)) {
                        return 'Password must contain at least one special character';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 16),
                AnimatedFormField(
                  animation: _animationController,
                  delay: 0.4,
                  child: TermsAndConditions(
                    onChanged: (value) {
                      setState(() {
                        _isTermsAccepted = value;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 16),
                BlocBuilder<SignupCubit, SignupState>(
                  builder: (context, state) {
                    return AnimatedFormField(
                      animation: _animationController,
                      delay: 0.5,
                      child: CustomButton(
                        onPressed: state is SignupLoading ? null : _submit,
                        buttonText: 'Create account',
                        isLoading: state is SignupLoading,
                        showLoadingIndicator: false,
                      ),
                    );
                  },
                ),
                const SizedBox(height: 16),
                AnimatedFormField(
                  animation: _animationController,
                  delay: 0.6,
                  child: const HaveAnAccount(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
