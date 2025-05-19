import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pickpay/core/services/firebase_auth_service.dart';
import 'package:pickpay/core/themes/app_themes.dart';
import 'package:pickpay/core/themes/theme_provider.dart';
import 'package:pickpay/features/auth/domain/repos/auth_repo.dart';
import 'package:pickpay/features/profile_change/cubits/cubit/profile_chnage_cubit.dart';
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
import 'package:permission_handler/permission_handler.dart';

// Add RouteObserver at the top level
final RouteObserver<ModalRoute> routeObserver = RouteObserver<ModalRoute>();
final firebaseAuthService = getIt<FirebaseAuthService>();
final authRepo = getIt<AuthRepo>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await requestStoragePermission();

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
        BlocProvider(
          create: (context) => ProfileCubit(
            firebaseAuthService: firebaseAuthService,
            authRepo: authRepo,
          ),
        ),
      ],
      child: ChangeNotifierProvider(
        create: (_) => ThemeProvider(),
        child: const Pickpay(),
      ),
    ),
  );
}

Future<void> requestStoragePermission() async {
  if (!Platform.isAndroid) return;

  final androidInfo = await DeviceInfoPlugin().androidInfo;
  final sdkInt = androidInfo.version.sdkInt;

  Permission permissionToRequest;

  if (sdkInt >= 33) {
    // Android 13+ → READ_MEDIA_IMAGES
    permissionToRequest = Permission.photos;
  } else {
    // Android 12 or lower → READ_EXTERNAL_STORAGE
    permissionToRequest = Permission.storage;
  }

  final status = await permissionToRequest.status;
  if (status.isGranted) return;

  final result = await permissionToRequest.request();
  if (result.isPermanentlyDenied) {
    // المستخدم اختار "Don't ask again"
    await openAppSettings();
  } else if (result.isDenied) {
    print('❌ Permission denied.');
  }
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
