import 'package:flutter/material.dart';
import 'package:memento_mori/models/story_model.dart';
import 'package:memento_mori/services/story_service.dart';
import 'package:memento_mori/shared/messages.dart';
import 'package:memento_mori/state/home_state.dart';

class HomeController extends ChangeNotifier with MessageStateMixin {
  final StoryService _service;

  HomeState state = HomeStateInitial();
  Set<String> _segmentSelected = {};
  Set<String> get segmentSelected => _segmentSelected;
  List<StoryModel> _allStories = [];
  List<StoryModel> _stories = [];
  HomeController({required StoryService service}) : _service = service;

  void updateSegment(Set<String> selected) {
    _segmentSelected = selected;
    _filterStories();
  }

  void _filterStories() {
    if (_segmentSelected.isEmpty) {
      _stories = _allStories;
    } else {
      _stories = _allStories.where((story) => getCategoryLabel(story.category) == _segmentSelected.first).toList();
    }
    state = HomeStateSuccess(_stories);
    notifyListeners();
  }

  Future<void> getStories() async {
    try {
      _allStories = await _service.fetch();
      _stories = _allStories;
      state = HomeStateSuccess(_stories);
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

  String getCategoryLabel(String category) {
    switch (category) {
      case 'Raiva':
        return 'angry';
      case 'Ansiedade':
        return 'anxiety';
      case 'Alegria':
        return 'happy';
      case 'Amor':
        return 'love';
      case 'Tristeza':
        return 'sad';
      default:
        return '';
    }
  }
}
