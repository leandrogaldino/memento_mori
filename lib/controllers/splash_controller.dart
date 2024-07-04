import 'package:flutter/foundation.dart';
import 'package:memento_mori/services/secure_storage_service.dart';
import 'package:memento_mori/state/splash_state.dart';

class SplashController extends ChangeNotifier {
  final SecureStorageService service;

  SplashController(this.service);

  SplashState _state = SplashStateInitial();

  SplashState get state => _state;

  void _changeState(SplashState newState) {
    _state = newState;
    notifyListeners();
  }

  void isUserLogged() async {
    await Future.delayed(const Duration(seconds: 3));
    const storage = SecureStorageService();
    final userJson = await storage.read(key: 'CURRENT_USER');
    if (userJson != null) {
      _changeState(SplashStateSuccess());
    } else {
      _changeState(SplashStateError());
    }
  }
}
