import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pickpay/core/themes/app_themes.dart';
import 'package:pickpay/core/themes/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:pickpay/core/helper_functions/on_generate_routes.dart';
import 'package:pickpay/core/services/get_it_service.dart';
import 'package:pickpay/core/services/shared_preferences_singletone.dart';
import 'package:pickpay/features/checkout/presentation/cubits/cubit/checkout_cubit.dart';
import 'package:pickpay/features/bottom_navigation/bottom_navigation_cubits/bottom_navigation_cubit.dart';
import 'package:pickpay/features/cart/cart_cubits/cart_cubit.dart';
import 'package:pickpay/features/wishlist/wishlist_cubits/wishlist_cubit.dart';
import 'package:pickpay/features/splash/presentation/views/splash_view.dart';
import 'package:pickpay/firebase_options.dart';

// Add RouteObserver at the top level
final RouteObserver<ModalRoute> routeObserver = RouteObserver<ModalRoute>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await Prefs.init();
  setupGetIt();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => CartCubit()),
        BlocProvider(create: (context) => WishlistCubit()),
        BlocProvider(create: (context) => CheckoutCubit()),
        BlocProvider(create: (context) => BottomNavigationCubit()),
      ],
      child: ChangeNotifierProvider(
        create: (_) => ThemeProvider(),
        child: const Pickpay(),
      ),
    ),
  );
}

class Pickpay extends StatelessWidget {
  const Pickpay({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      title: 'PickPay',
      theme: AppThemes.lightTheme,
      darkTheme: AppThemes.darkTheme,
      themeMode: themeProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
      onGenerateRoute: onGenerateRoute,
      initialRoute: SplashView.routeName,

      debugShowCheckedModeBanner: false,
      // Add the routeObserver to navigatorObservers
      navigatorObservers: [routeObserver],
      builder: (context, child) {
        return AnimatedTheme(
          data: themeProvider.isDarkMode
              ? AppThemes.darkTheme
              : AppThemes.lightTheme,
          child: child!,
        );
      },
    );
  }
}
