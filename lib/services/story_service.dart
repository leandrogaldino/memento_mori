import 'package:memento_mori/interfaces/local_db.dart';
import 'package:memento_mori/interfaces/remote_db.dart';
import 'package:memento_mori/models/story_model.dart';

class StoryService {
  final RemoteDB _remoteDB;
  final LocalDB _localDB;

  StoryService({required RemoteDB remoteDB, required LocalDB localDB})
      : _remoteDB = remoteDB,
        _localDB = localDB;

  Future<void> sendComment(String id, String comment) async {
    await _remoteDB.update(collection: 'stories', documentId: id, field: 'comment', value: comment).then((value) async => await _localDB.save(id, {'comment': comment}));
  }

  Future<List<StoryModel>> fetch() async {
    int lastId = _localDB.lastId();
    final remoteStories = await _remoteDB.getAll(collection: 'stories', fromId: lastId);
    final localStories = await _localDB.getAll();

    List<Map<dynamic, dynamic>> allStories = [];
    allStories.addAll(localStories);
    allStories.addAll(remoteStories);

    allStories.sort((a, b) => b['id'].compareTo(a['id']));

    List<StoryModel> storyModels = remoteStories.map((e) => StoryModel.fromMap(e)).toList();
    for (var story in storyModels) {
      _localDB.save(story.id, story.toMap());
    }
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
