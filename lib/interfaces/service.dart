abstract class Service {
  Future<List<Map<String, dynamic>>> fetch({bool mark = true});
  Future<void> markAsFetched(String id);
  Future<void> sendComment(String id, String comment);
}
