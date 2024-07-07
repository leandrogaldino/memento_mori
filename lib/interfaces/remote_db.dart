abstract class RemoteDB {
  Future<List<Map<String, dynamic>>> getAll({required String collection, String? field, Object? isEqualTo});
  Future<void> update({required String collection, required String documentid, required String field, required dynamic value});
}
