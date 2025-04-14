
import 'package:flutter/material.dart';

import '../../features/auth/presentation/views/signin_view.dart';
import '../../features/auth/presentation/views/sign_up_view.dart';
import '../../features/on_boarding/presentation/views/on_boarding_view.dart';
import '../../features/splash/presentation/views/splash_view.dart'; 

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
   case SplashView.routeName : 
    return MaterialPageRoute(builder: (context)=> const SplashView());
   case OnBoardingView.routeName:
    return MaterialPageRoute(builder: (context)=> const OnBoardingView());
   case SigninView.routeName:
    return MaterialPageRoute(builder: (context)=> const SigninView());
   case SignUpView.routeName:
    return MaterialPageRoute(builder: (context)=> const SignUpView());
   default:
      return MaterialPageRoute(builder: (context) => const Scaffold());
  }
}
