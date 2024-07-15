abstract class RemoteDB {
  Future<List<Map<String, dynamic>>> getStoriesGreaterThan({required int id});
  Future<void> update({required String collection, required String documentid, required String field, required dynamic value});
}
