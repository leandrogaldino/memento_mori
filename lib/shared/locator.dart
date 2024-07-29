import 'package:get_it/get_it.dart';
import 'package:memento_mori/controllers/home_controller.dart';

import 'package:memento_mori/controllers/login_controller.dart';
import 'package:memento_mori/interfaces/auth.dart';
import 'package:memento_mori/interfaces/local_db.dart';
import 'package:memento_mori/interfaces/remote_db.dart';
import 'package:memento_mori/interfaces/storage.dart';
import 'package:memento_mori/services/auth_service.dart';
import 'package:memento_mori/services/firestore_service.dart';
import 'package:memento_mori/services/sqflite_service.dart';
import 'package:memento_mori/shared/Storage/secure_storage_service.dart';
import 'package:memento_mori/services/story_service.dart';

class Locator {
  Locator._();
  static final GetIt getIt = GetIt.instance;

  static void setup() {
    getIt.registerLazySingleton<Auth>(() => AuthService());
    getIt.registerLazySingleton<LocalDB>(() => SqfliteService.instance);
    getIt.registerLazySingleton<RemoteDB>(() => FirestoreService());
    getIt.registerLazySingleton<Storage>(() => const SecureStorageService());
    getIt.registerFactory<LoginController>(() => LoginController(service: getIt<Auth>()));
    getIt.registerFactory<StoryService>(() => StoryService(remoteDB: getIt<RemoteDB>(), localDB: getIt<LocalDB>()));
    getIt.registerFactory<HomeController>(() => HomeController(service: getIt<StoryService>()));
  }
}
