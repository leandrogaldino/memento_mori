import 'package:flutter/material.dart';
import 'package:memento_mori/services/story_service.dart';
import 'package:memento_mori/shared/messages.dart';
import 'package:memento_mori/state/home_state.dart';

class HomeController extends ChangeNotifier with MessageStateMixin {
  final StoryService _service;
  HomeState state = HomeStateInitial();

  HomeController({required StoryService service}) : _service = service;

  Future<void> getStories() async {
    try {
      final stories = await _service.fetch(mark: false);
      state = HomeStateSuccess(stories);
      notifyListeners();
    } on Exception catch (e) {
      state = HomeStateError(e.toString());
      notifyListeners();
      showError('Erro ao carregar');
    }
  }

  String getCategoryImagePath(String category) {
    return _service.getCategoryImagePath(category);
  }
}
