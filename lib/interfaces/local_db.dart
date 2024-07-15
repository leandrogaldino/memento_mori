abstract class LocalDB {
  Future<List<Map<dynamic, dynamic>>> getAll();

  Future<List<Map<dynamic, dynamic>>> getByCategory(String category);

  Future<List<Map<dynamic, dynamic>>> getFavorites();

  Future<void> save(String key, Map<String, dynamic> value);

  Future<void> delete(String key);

  int lastId();
}
