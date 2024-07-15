import 'dart:async';
import 'dart:developer';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:memento_mori/app.dart';
import 'package:memento_mori/firebase_options.dart';
import 'package:memento_mori/shared/database/hive_db.dart';
import 'package:memento_mori/shared/locator.dart';

void main() async {
  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      await HiveDB.init();
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      Locator.setup();
      runApp(const App());
    },
    (error, stack) {
      log('Erro não tratado', error: error, stackTrace: stack);
      throw error;
    },
  );
}
