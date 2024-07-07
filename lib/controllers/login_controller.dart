import 'package:flutter/material.dart';
import 'package:memento_mori/interfaces/auth.dart';
import 'package:memento_mori/shared/exceptions/auth_exception.dart';
import 'package:memento_mori/shared/messages.dart';

class LoginController with MessageStateMixin {
  final Auth _service;

  LoginController({required Auth service}) : _service = service;

  final _obscurePassword = ValueNotifier<bool>(true);
  ValueNotifier<bool> get obscurePassword => _obscurePassword;

  void toggleObscurePassword() => _obscurePassword.value = !_obscurePassword.value;

  Future<void> singIn(String email, String password) async {
    try {
      await _service.signIn(email: email, password: password);
    } on AuthException catch (e) {
      showError(e.message);
    } on Exception catch (e) {
      showError('Erro: $e');
    }
  }

  Future<void> signOut() async {
    await _service.signOut();
  }
}
