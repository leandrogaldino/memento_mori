import 'package:memento_mori/interfaces/remote_db.dart';
import 'package:memento_mori/interfaces/service.dart';
import 'package:memento_mori/models/story_model.dart';

class StoryService implements Service<StoryModel> {
  final RemoteDB _service;

  StoryService({required RemoteDB service}) : _service = service;

  @override
  Future<void> markAsFetched(String id) async {
    await _service.update(collection: 'stories', documentid: id, field: 'fetched', value: true);
  }

  @override
  Future<void> sendComment(String id, String comment) async {
    await _service.update(collection: 'stories', documentid: id, field: 'comment', value: comment);
  }

  @override
  Future<List<StoryModel>> fetch({bool mark = true}) async {
    var stories = await _service.getAll(collection: 'stories', field: 'fetched', isEqualTo: false);
    if (mark) {
      for (var story in stories) {
        await markAsFetched(story['id']);
      }
    }
    List<StoryModel> storyModels = stories.map((e) => StoryModel.fromMap(e)).toList();
    return storyModels;
  }

  String getCategoryImagePath(String category) {
    switch (category) {
      case 'Raiva':
        return 'assets/images/angry.png';
      case 'Ansiedade':
        return 'assets/images/anxiety.png';
      case 'Alegria':
        return 'assets/images/happy.png';
      case 'Amor':
        return 'assets/images/love.png';
      case 'Tristeza':
        return 'assets/images/sad.png';
      default:
        return '';
    }
  }
}
