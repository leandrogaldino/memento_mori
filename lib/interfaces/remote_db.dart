abstract class RemoteDB {
  Future<void> save({required String collection, required String document, required Map<String, dynamic> data});
  Future<Map<String, dynamic>?> getOne({required String collection, required String document});
  Future<void> delete({required String collection, required String document});
  Future<List<Map<String, dynamic>>> getAll({
    required String collection,
    String? field,
    Object? isEqualTo,
    Object? isNotEqualTo,
    Object? isLessThan,
    Object? isLessThanOrEqualTo,
    Object? isGreaterThan,
    Object? isGreaterThanOrEqualTo,
    Object? arrayContains,
    Iterable<Object?>? arrayContainsAny,
    Iterable<Object?>? whereIn,
    Iterable<Object?>? whereNotIn,
    bool? isNull,
  });
}
