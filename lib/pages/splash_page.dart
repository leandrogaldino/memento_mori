import 'package:flutter/material.dart';
import 'package:memento_mori/controllers/splash_controller.dart';
import 'package:memento_mori/services/secure_storage_service.dart';
import 'package:memento_mori/shared/loader.dart';
import 'package:memento_mori/shared/routes.dart';
import 'package:memento_mori/state/splash_state.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final SplashController _splashController = SplashController(const SecureStorageService());

  @override
  void initState() {
    super.initState();
    _splashController.isUserLogged();
    _splashController.addListener(() {
      if (_splashController.state is SplashStateSuccess) {
        Navigator.pushReplacementNamed(context, Routes.home);
      } else {
        Navigator.pushReplacementNamed(context, Routes.login);
      }
    });
  }

  @override
  void dispose() {
    _splashController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Loader();
  }
}
