import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pickpay/core/helper_functions/on_generate_routes.dart';
import 'package:pickpay/core/services/get_it_service.dart';
import 'package:pickpay/core/services/shared_preferences_singletone.dart';
import 'package:pickpay/features/splash/presentation/views/splash_view.dart';
import 'package:pickpay/firebase_options.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); 

 await Supabase.initialize(
    url: 'https://bugyerxstajszzjqknmy.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImJ1Z3llcnhzdGFqc3p6anFrbm15Iiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTc0NTE1MTU1OCwiZXhwIjoyMDYwNzI3NTU4fQ.vgPdLVBQj4KbwCiiNUVLVSEWS1YlFny-ivfwHoIf-Uw',
  );
  
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await Prefs.init();
  setupGetit();
  runApp(const Pickpay());
}

class Pickpay extends StatelessWidget {
  const Pickpay({super.key});

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
