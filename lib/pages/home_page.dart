import 'package:asyncstate/asyncstate.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:memento_mori/controllers/home_controller.dart';
import 'package:memento_mori/services/story_service.dart';
import 'package:memento_mori/shared/database/firebase_firestore_db.dart';
import 'package:memento_mori/shared/extensions/extension.dart';
import 'package:memento_mori/shared/messages.dart';
import 'package:memento_mori/state/home_state.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = HomeController(service: StoryService(service: FirebaseFirestoreService()));

  @override
  void initState() {
    //TODO ver como e feito o state
    //TODO ver sobre a splash page, com o png que esta no asset
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await controller.getStories().asyncLoader();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: controller,
      builder: (context, child) {
        final state = controller.state;
        Widget body = Container();
        if (state is HomeStateError) {
          body = const Text('ERRO');
          Messages.showError(state.errorMessage, context);
        } else if (state is HomeStateSuccess) {
          Messages.showSuccess('Dados carregados com sucesso', context);
          body = const Text('CARREGADO');
        }

        return Scaffold(body: body);
      },
    );
  }
}
