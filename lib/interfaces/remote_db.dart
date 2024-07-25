abstract class RemoteDB {
  Future<List<Map<String, dynamic>>> getAll({required String collection, int? fromId});
  Future<void> update({required String collection, required String documentId, required String field, required dynamic value});
}
