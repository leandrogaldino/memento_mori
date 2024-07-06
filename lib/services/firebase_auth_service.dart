import 'package:firebase_auth/firebase_auth.dart';
import 'package:memento_mori/interfaces/auth.dart';
import 'package:memento_mori/models/user_model.dart';
import 'package:memento_mori/shared/exceptions/auth_exception.dart';

class FirebaseAuthService implements Auth {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Future<UserModel> signIn({required String email, required String password}) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      return UserModel(id: credential.user!.uid, name: null, document: null, email: email, password: password);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'invalid-email':
          throw AuthException(message: 'E-Mail inválido');
        case 'invalid-credential':
          throw AuthException(message: 'Senha inválida');
        case 'too-many-requests':
          throw AuthException(message: 'O número máximo de requisições foi excedido, aguarde alguns minuitos e tente novamente.');
        case 'user-disabled':
          throw AuthException(message: 'Usuário desativado');
        default:
          throw AuthException(message: 'Erro: ${e.code}');
      }
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<void> signOut() async {
    await _auth.signOut();
  }
}
