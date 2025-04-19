import 'package:flutter/material.dart';
import 'package:pickpay/features/checkout/presentation/views/checkout_view.dart';
import 'package:pickpay/features/electronics/presentation/views/electronics_view.dart';
import 'package:pickpay/features/home/presentation/views/home_view.dart';

import '../../features/auth/presentation/views/signin_view.dart';
import '../../features/auth/presentation/views/sign_up_view.dart';
import '../../features/on_boarding/presentation/views/on_boarding_view.dart';
import '../../features/splash/presentation/views/splash_view.dart';

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case SplashView.routeName:
      return MaterialPageRoute(builder: (context) => const SplashView());
    case OnBoardingView.routeName:
      return MaterialPageRoute(builder: (context) => const OnBoardingView());
    case SigninView.routeName:
      return MaterialPageRoute(builder: (context) => const SigninView());
    case SignUpView.routeName:
      return MaterialPageRoute(builder: (context) => const SignUpView());
    case HomeView.routeName:
      return MaterialPageRoute(builder: (context) => const HomeView());
    case CheckoutView.routeName:
      return MaterialPageRoute(builder: (context) => const CheckoutView());
    case ElectronicsView.routeName:
      return MaterialPageRoute(builder: (context) => const ElectronicsView());
    default:
      return MaterialPageRoute(builder: (context) => const Scaffold());
  }
}
