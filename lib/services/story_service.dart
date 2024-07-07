import 'package:memento_mori/interfaces/remote_db.dart';
import 'package:memento_mori/interfaces/service.dart';

class StoryService implements Service {
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
  Future<List<Map<String, dynamic>>> fetch({bool mark = true}) async {
    var stories = await _service.getAll(collection: 'story', field: 'fetched', isEqualTo: false);
    if (mark) {
      for (var story in stories) {
        await markAsFetched(story['id']);
      }
    }
    return stories;
  }
}
