abstract class Service<T> {
  Future<List<T>> fetch({bool mark = true});
  Future<void> markAsFetched(String id);
  Future<void> sendComment(String id, String comment);
}
