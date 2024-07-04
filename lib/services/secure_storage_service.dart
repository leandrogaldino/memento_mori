import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:memento_mori/interfaces/storage.dart';

final class SecureStorageService implements Storage {
  const SecureStorageService();

  final _secureStorage = const FlutterSecureStorage();

  @override
  Future<void> write({required String key, required String value}) async {
    await _secureStorage.write(key: key, value: value);
  }

  @override
  Future<String?> read({required String key}) async {
    return await _secureStorage.read(key: key);
  }

  @override
  Future<void> delete() async {
    await _secureStorage.deleteAll();
  }
}
