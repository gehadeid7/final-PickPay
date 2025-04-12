import 'package:flutter/material.dart';
import 'package:pickpay/features/auth/presentation/views/login_view.dart';
import 'package:pickpay/features/auth/presentation/views/sign_up_view.dart';
import 'package:pickpay/features/on_boarding/presentation/views/on_boarding_view.dart';
import 'package:pickpay/features/splash/presentation/views/splash_view.dart';

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
   case SplashView.routeName : 
    return MaterialPageRoute(builder: (context)=> const SplashView());
   case OnBoardingView.routeName:
    return MaterialPageRoute(builder: (context)=> const OnBoardingView());
   case LoginView.routeName:
    return MaterialPageRoute(builder: (context)=> const LoginView());
   case SignUpView.routeName:
    return MaterialPageRoute(builder: (context)=> const SignUpView());
   default:
      return MaterialPageRoute(builder: (context) => const Scaffold());
  }
}
