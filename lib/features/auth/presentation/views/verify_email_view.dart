import 'dart:ui'; // ضروري لـ Blur
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

    // إعداد تأثير التوهج Glow للأيقونة
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
                'تم إرسال رابط التحقق بنجاح',
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
                // خلفية ملونة بسيطة
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        theme.colorScheme.primary.withOpacity(0.8),
                        theme.colorScheme.secondary.withOpacity(0.7),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                ),

                // تأثير Blur وزجاجي على محتوى الصفحة
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
                                  ? Colors.black.withOpacity(0.4)
                                  : Colors.white.withOpacity(0.4)),
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.2),
                            width: 1.5,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: theme.colorScheme.primary.withOpacity(0.3),
                              blurRadius: 20,
                              spreadRadius: 5,
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // أيقونة مع توهج متحرك Glow
                            AnimatedBuilder(
                              animation: _glowAnimation,
                              builder: (context, child) {
                                return Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: theme.colorScheme.primary
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
                              'يرجى التحقق من بريدك الإلكتروني',
                              style: theme.textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                                shadows: [
                                  Shadow(
                                    color:
                                        theme.colorScheme.primary.withOpacity(0.5),
                                    blurRadius: 8,
                                  ),
                                ],
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'لقد أرسلنا رابط التحقق إلى بريدك. الرجاء التحقق من صندوق الوارد والنقر على الرابط لتفعيل حسابك.',
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: theme.colorScheme.onSurface.withOpacity(0.8),
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
                                          'يمكنك إعادة إرسال الرابط بعد $countdown ثانية',
                                          style: theme.textTheme.bodyMedium?.copyWith(
                                            color: theme.colorScheme.onSurface
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
                                  'إعادة إرسال رابط التحقق',
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
                                  padding: const EdgeInsets.symmetric(vertical: 16),
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
                                  'العودة إلى تسجيل الدخول',
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
