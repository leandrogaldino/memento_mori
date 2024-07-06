import 'package:flutter/material.dart';
import 'package:memento_mori/pages/home_page.dart';
import 'package:memento_mori/pages/login_page.dart';
import 'package:memento_mori/shared/app_theme.dart';
import 'package:memento_mori/shared/auth_state_listener.dart';
import 'package:memento_mori/shared/routes.dart';

class App extends StatelessWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Memento Mori',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      home: const AuthStateListener(),
      routes: {
        Routes.home: (context) => const HomePage(),
        Routes.login: (context) => const LoginPage(),
      },
    );
  }
}
