import 'package:get_it/get_it.dart';
import 'package:memento_mori/controllers/login_controller.dart';
import 'package:memento_mori/interfaces/auth.dart';
import 'package:memento_mori/interfaces/remote_db.dart';
import 'package:memento_mori/interfaces/storage.dart';
import 'package:memento_mori/shared/auth/firebase_auth_service.dart';
import 'package:memento_mori/shared/database/firebase_firestore_db.dart';
import 'package:memento_mori/shared/Storage/secure_storage_service.dart';
import 'package:memento_mori/services/story_service.dart';

class Locator {
  Locator._();
  static final GetIt getIt = GetIt.instance;

  static void setup() {
    getIt.registerLazySingleton<Auth>(() => FirebaseAuthService());
    getIt.registerLazySingleton<RemoteDB>(() => FirebaseFirestoreService());
    getIt.registerLazySingleton<Storage>(() => const SecureStorageService());
    getIt.registerFactory<LoginController>(() => LoginController(service: getIt<Auth>()));
    getIt.registerFactory<StoryService>(() => StoryService(service: getIt<RemoteDB>()));
  }
}
