import 'package:get_it/get_it.dart';
import 'package:pickpay/core/services/database_services.dart';
import 'package:pickpay/core/services/firebase_auth_service.dart';
import 'package:pickpay/core/services/firestore_servies.dart';
import 'package:pickpay/features/auth/data/repos/auth_repo_implementation.dart';
import 'package:pickpay/features/auth/domain/repos/auth_repo.dart';
import 'package:pickpay/services/api_service.dart';  // Ensure you import ApiService

final getIt = GetIt.instance;

void setupGetIt() {
  // Register FirebaseAuthService as a singleton
  getIt.registerSingleton<FirebaseAuthService>(FirebaseAuthService());

  // Register FireStoreService as a singleton for DatabaseService
  getIt.registerSingleton<DatabaseService>(FireStoreService());

  // Register ApiService as a singleton
  getIt.registerSingleton<ApiService>(ApiService());

  // Register AuthRepoImplementation as a singleton
  getIt.registerSingleton<AuthRepo>(AuthRepoImplementation(
    firebaseAuthService: getIt<FirebaseAuthService>(),
    databaseService: getIt<DatabaseService>(),
    apiService: getIt<ApiService>(),  // Make sure to pass apiService here
  ));

  // Example for other services you may want to add in the future
  // getIt.registerSingleton<CartService>(CartService());
}
