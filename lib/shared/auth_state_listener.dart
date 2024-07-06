import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:memento_mori/pages/home_page.dart';
import 'package:memento_mori/pages/login_page.dart';

class AuthStateListener extends StatelessWidget {
  const AuthStateListener({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator(); // Exemplo de um widget de carregamento
        } else if (snapshot.hasData && snapshot.data != null) {
          // Usuário logado, redireciona para a página inicial
          return const HomePage();
        } else {
          // Usuário não logado, redireciona para a página de login
          return const LoginPage();
        }
      },
    );
  }
}
