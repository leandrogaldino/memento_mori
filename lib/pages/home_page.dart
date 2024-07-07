import 'package:asyncstate/asyncstate.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:memento_mori/services/story_service.dart';
import 'package:memento_mori/shared/extensions/extension.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _service = GetIt.instance<StoryService>();

  @override
  void initState() {
    //TODO Iniciar a tela fazendo um _service.fetch().withDelay(2).asyncLoader()
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('HOME PAGE'),
            FloatingActionButton(
              onPressed: () async {},
              child: const Text('Sair'),
            ),
          ],
        ),
      ),
    );
  }
}
