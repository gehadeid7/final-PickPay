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
  @override
  void initState() {
    super.initState();
    _navigateAfterSplash();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "PickPay",
              style: TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.bold,
                foreground: Paint()
                  ..shader = const LinearGradient(
                    colors: <Color>[
                      Color(0xFFFE1679), // pink
                      Color(0xFF5440B3), // purple
                    ],
                  ).createShader(const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0)),
              ),
            ),
            const SizedBox(height: 32),
            Image.asset(Assets.appLogo, width: 250, height: 250),
          ],
        ),
      ),
    );
  }

  Future<void> _navigateAfterSplash() async {
    await Future.delayed(const Duration(seconds: 2)); // Splash delay

    final bool isOnBoardingSeen = Prefs.getBool(kIsOnBoardingViewSeen);
    final bool isLoggedIn = FirebaseAuthService().isLoggedIn();

    if (!isOnBoardingSeen) {
      Navigator.pushReplacementNamed(context, OnBoardingView.routeName);
    } else if (isLoggedIn) {
      Navigator.pushReplacementNamed(context, MainNavigationScreen.routeName);
    } else {
      Navigator.pushReplacementNamed(context, SigninView.routeName);
    }
  }
}
