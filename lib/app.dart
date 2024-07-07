import 'package:asyncstate/asyncstate.dart';
import 'package:flutter/material.dart';
import 'package:memento_mori/pages/home_page.dart';
import 'package:memento_mori/pages/login_page.dart';
import 'package:memento_mori/shared/app_theme.dart';
import 'package:memento_mori/shared/auth/auth_state_listener.dart';
import 'package:memento_mori/shared/loader.dart';
import 'package:memento_mori/shared/routes.dart';

class App extends StatelessWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context) {
    return AsyncStateBuilder(
      enableLog: true,
      customLoader: const Loader(
        message: 'Por favor aguarde',
      ),
      builder: (nO) => MaterialApp(
        title: 'Memento Mori',
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        home: const AuthStateListener(),
        navigatorObservers: [nO],
        routes: {
          Routes.home: (context) => const HomePage(),
          Routes.login: (context) => const LoginPage(),
        },
      ),
    );
  }
}
