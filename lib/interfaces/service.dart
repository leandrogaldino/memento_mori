abstract class Service<T> {
  Future<List<T>> fetch();
  Future<void> sendComment(String id, String comment);
}
