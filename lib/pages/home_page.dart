import 'package:flutter/material.dart';
import 'package:memento_mori/app.dart';
import 'package:memento_mori/controllers/home_controller.dart';
import 'package:memento_mori/models/story_model.dart';
import 'package:memento_mori/services/story_service.dart';
import 'package:memento_mori/shared/app_theme.dart';
import 'package:memento_mori/shared/database/firebase_firestore_db.dart';
import 'package:memento_mori/shared/extensions/date_time_extension.dart';
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
  Set<String> segmentSelected = {'A'};

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

          body = Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 30,
                child: SegmentedButton<String>(
                  segments: const [
                    ButtonSegment(
                      value: 'A',
                      label: Text('A'),
                    ),
                    ButtonSegment(
                      value: 'B',
                      label: Text('B'),
                    ),
                    ButtonSegment(
                      value: 'C',
                      label: Text('C'),
                    ),
                  ],
                  emptySelectionAllowed: true,
                  selected: segmentSelected,
                  onSelectionChanged: (selected) {
                    segmentSelected = selected;
                    setState(() {});
                  },
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: stories.length,
                  itemBuilder: (context, index) {
                    final StoryModel story = stories[index];
                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey[300]!), // Define a cor da borda
                        borderRadius: BorderRadius.circular(8.0), // Opcional: bordas arredondadas
                      ),
                      child: ListTile(
                        tileColor: AppTheme.secondaryColor,
                        leading: Image.asset(
                          controller.getCategoryImagePath(story.category),
                          width: 32,
                          height: 32,
                        ),
                        title: Text(story.title),
                        subtitle: Text(story.date.toFormattedString()),
                        trailing: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: story.favorite
                                  ? const Icon(
                                      Icons.favorite,
                                      color: Colors.red,
                                    )
                                  : const Icon(
                                      Icons.favorite_border,
                                    ),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: story.comment != '' ? const Icon(Icons.comment_outlined) : const Icon(Icons.comment_outlined),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          );
        }

        return Scaffold(
            appBar: AppBar(
              title: const Text('Memento Mori'),
              centerTitle: true,
              backgroundColor: Colors.blue, // Cor de fundo da appbar
              elevation: 4, // Sombra da appbar
              actions: <Widget>[
                IconButton(
                  icon: const Icon(Icons.settings),
                  onPressed: () {
                    // Implementar ação de configurações aqui
                  },
                ),
              ],
            ),
            body: body);
      },
    );
  }
}
