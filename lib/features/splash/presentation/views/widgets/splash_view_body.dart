import 'package:flutter/material.dart';
import 'package:pickpay/constants.dart';
import 'package:pickpay/core/services/firebase_auth_service.dart';
import 'package:pickpay/core/services/shared_preferences_singletone.dart';
import 'package:pickpay/core/utils/app_images.dart';
import 'package:pickpay/features/on_boarding/presentation/views/on_boarding_view.dart';
import 'package:pickpay/features/auth/presentation/views/signin_view.dart';
import 'package:pickpay/features/home/presentation/views/main_navigation_screen.dart';

class SplashViewBody extends StatefulWidget {
  const SplashViewBody({super.key});

  @override
  State<SplashViewBody> createState() => _SplashViewBodyState();
}

class _SplashViewBodyState extends State<SplashViewBody> {
  /// أقل زمن نريد أن يظهر فيه الـ Splash (للجانب الجمالي)
  static const Duration _minSplashDuration = Duration(milliseconds: 1500);

  @override
  void initState() {
    super.initState();
    _navigateAfterSplash();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _LogoAndTitle(),
            SizedBox(height: 40),
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFFE1679)),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _navigateAfterSplash() async {
    final stopwatch = Stopwatch()..start();

    // التهيئة بالتوازي
    final bool isOnBoardingSeen = Prefs.getBool(kIsOnBoardingViewSeen);
    final bool isLoggedIn = FirebaseAuthService().isLoggedIn();

    stopwatch.stop();

    // ننتظر الباقي فقط إذا كان الزمن أقل من المطلوب
    final remaining = _minSplashDuration - stopwatch.elapsed;
    if (remaining > Duration.zero) {
      await Future.delayed(remaining);
    }

    if (!mounted) return; // للتأكّد من أن الـ widget ما زال موجودًا

    if (!isOnBoardingSeen) {
      Navigator.pushReplacementNamed(context, OnBoardingView.routeName);
    } else if (isLoggedIn) {
      Navigator.pushReplacementNamed(context, MainNavigationScreen.routeName);
    } else {
      Navigator.pushReplacementNamed(context, SigninView.routeName);
    }
  }
}

/// فصلنا جزء الشعار واللوجو لتقليل الكود في البيلدر
class _LogoAndTitle extends StatelessWidget {
  const _LogoAndTitle();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'PickPay',
          style: TextStyle(
            fontSize: 50,
            fontWeight: FontWeight.bold,
            foreground: Paint()
              ..shader = const LinearGradient(
                colors: [
                  Color(0xFFFE1679), // pink
                  Color(0xFF5440B3), // purple
                ],
              ).createShader(const Rect.fromLTWH(0, 0, 200, 70)),
          ),
        ),
        const SizedBox(height: 32),
        Image.asset(Assets.appLogo, width: 250, height: 250),
      ],
    );
  }
}
