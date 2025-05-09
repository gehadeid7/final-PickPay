import 'package:flutter/material.dart';
import 'package:pickpay/features/auth/presentation/views/forgot_password_view.dart';
import 'package:pickpay/features/categories_pages/appliances/presentation/views/appliances_view.dart';
import 'package:pickpay/features/categories_pages/beauty/presentation/views/beauty_view.dart';
import 'package:pickpay/features/categories_pages/fashion/presentation/views/fashion_view.dart';
import 'package:pickpay/features/categories_pages/homeCategory/presentation/views/home_category_view.dart';
import 'package:pickpay/features/categories_pages/todayIsSale/presentation/views/sale_view.dart';
import 'package:pickpay/features/categories_pages/videogames/presentation/views/videogames_view.dart';
import 'package:pickpay/features/checkout/presentation/views/checkout_view.dart';
import 'package:pickpay/features/categories_pages/electronics/presentation/views/electronics_view.dart';
import 'package:pickpay/features/home/presentation/views/account_view.dart';
import 'package:pickpay/features/home/presentation/views/cart_view.dart';
import 'package:pickpay/features/home/presentation/views/categories_view.dart';
import 'package:pickpay/features/home/presentation/views/home_view.dart';
import 'package:pickpay/features/home/presentation/views/main_navigation_screen.dart';
import 'package:pickpay/features/home/presentation/views/wishlist_view.dart';

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
    case MainNavigationScreen.routeName:
      return MaterialPageRoute(
          builder: (context) => const MainNavigationScreen());
    case CartView.routeName:
      return MaterialPageRoute(builder: (context) => const CartView());
    case CategoriesView.routeName:
      return MaterialPageRoute(builder: (context) => const CategoriesView());

    case AccountView.routeName:
      return MaterialPageRoute(builder: (context) => const AccountView());

    case ElectronicsView.routeName:
      return MaterialPageRoute(builder: (context) => const ElectronicsView());

    case SaleView.routeName:
      return MaterialPageRoute(builder: (context) => const SaleView());

    case AppliancesView.routeName:
      return MaterialPageRoute(builder: (context) => const AppliancesView());

    case HomeCategoryView.routeName:
      return MaterialPageRoute(builder: (context) => const HomeCategoryView());

    case FashionView.routeName:
      return MaterialPageRoute(builder: (context) => const FashionView());
    case VideogamesView.routeName:
      return MaterialPageRoute(builder: (context) => const VideogamesView());
    case BeautyView.routeName:
      return MaterialPageRoute(builder: (context) => const BeautyView());

  case WishlistView.routeName:
      return MaterialPageRoute(builder: (context) => const WishlistView());
      
  case ForgotPasswordView.routeName:
      return MaterialPageRoute(builder: (context) => const ForgotPasswordView());


    default:
      return MaterialPageRoute(builder: (context) => const Scaffold());
  }
}
