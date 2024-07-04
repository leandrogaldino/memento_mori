import 'package:memento_mori/models/user_model.dart';

abstract class Auth {
  Future<UserModel> signIn({required String email, required String password});
  Future<void> signOut();
}
