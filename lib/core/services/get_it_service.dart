import 'package:get_it/get_it.dart';
import 'package:pickpay/core/services/database_services.dart';
import 'package:pickpay/core/services/firebase_auth_service.dart';
import 'package:pickpay/core/services/firestore_servies.dart';
import 'package:pickpay/features/auth/data/repos/auth_repo_implementation.dart';
import 'package:pickpay/features/auth/domain/repos/auth_repo.dart';

final getIt = GetIt.instance;

void setupGetit() {
  getIt.registerSingleton<FirebaseAuthService>(FirebaseAuthService());
  getIt.registerSingleton<DatabaseService>(FireStoreService());

  // getIt.registerSingleton<CartService>(CartService());

  getIt.registerSingleton<AuthRepo>(AuthRepoImplementation(
    firebaseAuthService: getIt<FirebaseAuthService>(),
    databaseService: getIt<DatabaseService>(),
  ));

  // getIt.registerSingleton<ProductsRepo>(ProductRepoImpl(
  //   getIt<DatabaseService>(),
  // ));
}
