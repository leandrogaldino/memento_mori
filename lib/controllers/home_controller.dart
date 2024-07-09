import 'package:asyncstate/asyncstate.dart';
import 'package:flutter/material.dart';
import 'package:memento_mori/services/story_service.dart';
import 'package:memento_mori/state/home_state.dart';

class HomeController extends ChangeNotifier {
  final StoryService _service;
  HomeState state = HomeStateInitial();

  HomeController({required StoryService service}) : _service = service;

  getStories() async {
    try {
      final stories = await _service.fetch().asyncLoader();
      state = HomeStateSuccess(stories);
      notifyListeners();
    } on Exception catch (e) {
      state = HomeStateError(e.toString());
    }
  }
}
