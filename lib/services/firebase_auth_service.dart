import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:memento_mori/interfaces/auth.dart';
import 'package:memento_mori/models/user_model.dart';

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
          log('E-mail inválido');
        case 'invalid-credential':
          log('Senha inválida');
        case 'too-many-requests':
          log('excedido o número de requisições');
        case 'user-disabled':
          log('usuário desabilitado');
          break;
        default:
      }
      rethrow;
    } on Exception catch (e) {
      log('erro ao entrar: $e');
      rethrow;
    }
  }

  @override
  Future<void> signOut() async {
    await _auth.signOut();
  }
}
