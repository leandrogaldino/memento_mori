abstract class LocalDB {
  Future<int> getLastId({required String table});
  Future<void> delete(String table, {String? where, List<Object?>? whereArgs});
  Future<int> save(String table, Map<String, Object?> values);
  Future<List<Map<String, Object?>>> get(String table, {List<String>? columns, String? where, List<Object?>? whereArgs, String? orderBy});
}
