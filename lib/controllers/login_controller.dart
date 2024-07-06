import 'package:memento_mori/services/firebase_auth_service.dart';
import 'package:memento_mori/shared/exceptions/auth_exception.dart';
import 'package:memento_mori/shared/messages.dart';

class LoginController with MessageStateMixin {
  Future<void> singIn(String email, String password) async {
    try {
      await FirebaseAuthService().signIn(email: email, password: password);
    } on AuthException catch (e) {
      showError(e.message);
    } on Exception catch (e) {
      showError('Erro: $e');
    }
  }
}
