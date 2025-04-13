import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pickpay/core/helper_functions/on_generate_routes.dart';
import 'package:pickpay/core/services/shared_preferences_singletone.dart';
import 'package:pickpay/features/splash/presentation/views/splash_view.dart';
import 'package:pickpay/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); 
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await Prefs.init();
  runApp(const pickpay());
}

class pickpay extends StatelessWidget {
  const pickpay({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Montserrat',
        scaffoldBackgroundColor: Colors.white,
      ),
      

      onGenerateRoute: onGenerateRoute,
      initialRoute: SplashView.routeName,
      debugShowCheckedModeBanner: false,
    );
  }
}
