import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:memento_mori/controllers/home_controller.dart';
import 'package:memento_mori/models/story_model.dart';
import 'package:memento_mori/shared/app_theme.dart';
import 'package:memento_mori/shared/database/firebase_firestore_db.dart';
import 'package:memento_mori/shared/database/hive_db.dart';
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
  final controller = GetIt.I<HomeController>();

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
          body = const Center(child: Text('ERRO'));
        } else if (state is HomeStateSuccess) {
          List<StoryModel> stories = state.stories;
          body = Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SegmentedButton<String>(
                  segments: const [
                    ButtonSegment(
                      value: 'happy',
                      label: Text('Alegria'),
                    ),
                    ButtonSegment(
                      value: 'love',
                      label: Text('Amor'),
                    ),
                    ButtonSegment(
                      value: 'anxiety',
                      label: Text('Ansiedade'),
                    ),
                    ButtonSegment(
                      value: 'angry',
                      label: Text('Raiva'),
                    ),
                    ButtonSegment(
                      value: 'sad',
                      label: Text('Tristeza'),
                    ),
                    ButtonSegment(
                      value: 'favorites',
                      label: Text('Favoritos'),
                    ),
                  ],
                  emptySelectionAllowed: true,
                  selected: controller.segmentSelected,
                  onSelectionChanged: (selected) {
                    controller.updateSegment(selected);
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
                        border: Border.all(color: Colors.grey[300]!),
                        borderRadius: BorderRadius.circular(8.0),
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
                                      color: AppTheme.primaryColor,
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
              title: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Silent',
                      style: AppTheme.titleStyle,
                    ),
                    TextSpan(
                      text: 'Pen',
                      style: AppTheme.titleStyle.copyWith(color: AppTheme.primaryColor),
                    ),
                    const WidgetSpan(
                      child: Icon(
                        Icons.create,
                        size: 38,
                        color: AppTheme.textColor,
                      ),
                    ),
                  ],
                ),
              ),
              centerTitle: true,
              backgroundColor: AppTheme.backgroudColor, // Cor de fundo da appbar
              elevation: 4, // Sombra da appbar
              actions: [
                PopupMenuButton(
                  icon: const Icon(Icons.more_vert),
                  itemBuilder: (_) => [
                    PopupMenuItem(
                      child: ListTile(
                        leading: const Icon(Icons.brightness_7),
                        title: const Text('Claro'),
                        onTap: () async {
                          var db = FirebaseFirestoreDB();
                          var ldb = HiveDB();
                          var a = await db.getStoriesGreaterThan(id: ldb.lastId());
                          log(a.toString());
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
            body: body);
      },
    );
  }
}
