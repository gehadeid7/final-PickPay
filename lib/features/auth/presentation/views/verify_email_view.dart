import 'dart:ui'; // Required for Blur
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pickpay/features/auth/presentation/cubits/verify_email_state.dart/verify_email_cubit.dart';
import 'package:pickpay/features/auth/presentation/views/signin_view.dart';
import 'package:pickpay/core/widgets/app_flushbar.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({super.key});

  static const routeName = '/verify_email';

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView>
    with SingleTickerProviderStateMixin {
  late AnimationController _iconGlowController;
  late Animation<double> _glowAnimation;

  @override
  void initState() {
    super.initState();

    // Setup Glow effect animation for the icon
    _iconGlowController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _glowAnimation = Tween<double>(begin: 0.4, end: 1.0).animate(
      CurvedAnimation(
        parent: _iconGlowController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _iconGlowController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return BlocProvider(
      create: (_) => VerifyEmailCubit()..startAutoRedirect(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Verify Your Email'),
          backgroundColor:
              isDarkMode ? theme.appBarTheme.backgroundColor : Colors.white,
          foregroundColor: isDarkMode ? Colors.white : Colors.black,
          elevation: 1,
        ),
        body: BlocConsumer<VerifyEmailCubit, VerifyEmailState>(
          listener: (context, state) {
            if (state is VerifyEmailSuccess) {
              AppFlushbar.showSuccess(
                context,
                'Verification link sent successfully',
              );
            } else if (state is VerifyEmailFailure) {
              AppFlushbar.showError(
                context,
                state.message,
              );
            } else if (state is VerifyEmailRefreshed) {
              Navigator.pushReplacementNamed(context, SigninView.routeName);
            }
          },
          builder: (context, state) {
            final cubit = context.read<VerifyEmailCubit>();

            return Stack(
              children: [
                // Simple colored background
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        // ignore: deprecated_member_use
                        theme.colorScheme.primary.withOpacity(0.8),
                        // ignore: deprecated_member_use
                        theme.colorScheme.secondary.withOpacity(0.7),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                ),

                // Blur and glass effect on page content
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.85,
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: (isDarkMode
                              // ignore: deprecated_member_use
                              ? Colors.black.withOpacity(0.4)
                              // ignore: deprecated_member_use
                              : Colors.white.withOpacity(0.4)),
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(
                            // ignore: deprecated_member_use
                            color: Colors.white.withOpacity(0.2),
                            width: 1.5,
                          ),
                          boxShadow: [
                            BoxShadow(
                              // ignore: deprecated_member_use
                              color: theme.colorScheme.primary.withOpacity(0.3),
                              blurRadius: 20,
                              spreadRadius: 5,
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Icon with animated Glow effect
                            AnimatedBuilder(
                              animation: _glowAnimation,
                              builder: (context, child) {
                                return Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: theme.colorScheme.primary
                                            // ignore: deprecated_member_use
                                            .withOpacity(_glowAnimation.value),
                                        blurRadius: 30,
                                        spreadRadius: 5,
                                      ),
                                    ],
                                  ),
                                  child: child,
                                );
                              },
                              child: Icon(
                                Icons.mark_email_unread_outlined,
                                size: 80,
                                color: theme.colorScheme.primary,
                              ),
                            ),
                            const SizedBox(height: 24),
                            Text(
                              'Please check your email',
                              style: theme.textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                                shadows: [
                                  Shadow(
                                    color:
                                        // ignore: deprecated_member_use
                                        theme.colorScheme.primary
                                            // ignore: deprecated_member_use
                                            .withOpacity(0.5),
                                    blurRadius: 8,
                                  ),
                                ],
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'We have sent a verification link to your email. Please check your inbox and click on the link to activate your account.',
                              style: theme.textTheme.bodyMedium?.copyWith(
                                // ignore: deprecated_member_use
                                color: theme.colorScheme.onSurface
                                    // ignore: deprecated_member_use
                                    .withOpacity(0.8),
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 32),

                            if (state is VerifyEmailLoading)
                              CircularProgressIndicator(
                                color: theme.colorScheme.primary,
                              ),

                            StreamBuilder<int>(
                              stream: cubit.countdownController.stream,
                              builder: (context, snapshot) {
                                final countdown = snapshot.data ?? 0;
                                return countdown > 0
                                    ? Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 16),
                                        child: Text(
                                          'You can resend the link after $countdown seconds',
                                          style: theme.textTheme.bodyMedium
                                              ?.copyWith(
                                            color: theme.colorScheme.onSurface
                                                // ignore: deprecated_member_use
                                                .withOpacity(0.6),
                                            fontStyle: FontStyle.italic,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      )
                                    : const SizedBox.shrink();
                              },
                            ),

                            const SizedBox(height: 16),

                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: (state is VerifyEmailLoading ||
                                        state is VerifyEmailButtonDisabled)
                                    ? null
                                    : () {
                                        cubit.stopAutoRedirect();
                                        cubit.sendVerificationEmail();
                                      },
                                style: ElevatedButton.styleFrom(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 16),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  backgroundColor: theme.colorScheme.primary,
                                  foregroundColor: Colors.white,
                                  elevation: 4,
                                ),
                                child: const Text(
                                  'Resend Verification Link',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                            ),

                            const SizedBox(height: 12),

                            SizedBox(
                              width: double.infinity,
                              child: OutlinedButton(
                                onPressed: () {
                                  Navigator.pushReplacementNamed(
                                      context, SigninView.routeName);
                                },
                                style: OutlinedButton.styleFrom(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 16),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  side: BorderSide(
                                    color: theme.colorScheme.primary,
                                    width: 1.5,
                                  ),
                                  foregroundColor: theme.colorScheme.primary,
                                ),
                                child: const Text(
                                  'Back to Sign In',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
