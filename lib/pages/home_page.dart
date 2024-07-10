import 'package:flutter/material.dart';
import 'package:memento_mori/controllers/home_controller.dart';
import 'package:memento_mori/models/story_model.dart';
import 'package:memento_mori/services/story_service.dart';
import 'package:memento_mori/shared/database/firebase_firestore_db.dart';
import 'package:memento_mori/shared/messages.dart';
import 'package:memento_mori/state/home_state.dart';
import 'package:asyncstate/asyncstate.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with MessageViewMixin {
  final controller = HomeController(service: StoryService(service: FirebaseFirestoreService()));

  @override
  void initState() {
    messageListener(controller);
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
        } else if (state is HomeStateSuccess) {
          List<StoryModel> stories = state.stories;

          body = ListView.builder(
              itemCount: stories.length,
              itemBuilder: (context, index) {
                final StoryModel story = stories[index];
                return ListTile(
                  title: Text(story.title),
                );
              });
        }

        return Scaffold(body: body);
      },
    );
  }
}
