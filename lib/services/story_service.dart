import 'package:memento_mori/interfaces/local_db.dart';
import 'package:memento_mori/interfaces/remote_db.dart';
import 'package:memento_mori/interfaces/service.dart';
import 'package:memento_mori/models/story_model.dart';

class StoryService implements Service<StoryModel> {
  final RemoteDB _remoteDB;
  final LocalDB _localDB;

  StoryService({required RemoteDB remoteDB, required LocalDB localDB})
      : _remoteDB = remoteDB,
        _localDB = localDB;

  @override
  Future<void> sendComment(String id, String comment) async {
    //TODO verificar se esse save esta salvando o comentario corretamente
    await _localDB.save(id, {'comment': comment});
    await _remoteDB.update(collection: 'stories', documentid: id, field: 'comment', value: comment);
  }

//TODO Fazer testes nesse fetch
  @override
  Future<List<StoryModel>> fetch() async {
    int lastId = _localDB.lastId();
    final remoteStories = await _remoteDB.getStoriesGreaterThan(id: lastId);
    final localStories = await _localDB.getAll();

    List<Map<dynamic, dynamic>> allStories = [];
    allStories.addAll(localStories);
    allStories.addAll(remoteStories);

    allStories.sort((a, b) {
      int idA = a['id'];
      int idB = b['id'];
      return idB.compareTo(idA); // Ordena em ordem decrescente
    });

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
