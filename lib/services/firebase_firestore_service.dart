import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:memento_mori/interfaces/remote_db.dart';

class FirebaseFirestoreService implements RemoteDB {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  @override
  Future<void> save({required String collection, required String document, required Map<String, dynamic> data}) async {
    await _db.collection(collection).doc(document).set(data);
  }

  @override
  Future<Map<String, dynamic>?> getOne({required String collection, required String document}) async {
    final documentSnapshot = await _db.collection(collection).doc(document).get();
    final data = documentSnapshot.data();
    return data;
  }

  @override
  Future<void> delete({required String collection, required String document}) async {
    await _db.collection(collection).doc(document).delete();
  }

  @override
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
  }) async {
    try {
      QuerySnapshot querySnapshot = await _db
          .collection(collection)
          .where(
            field ?? '',
            isEqualTo: isEqualTo,
            isNotEqualTo: isNotEqualTo,
            isLessThan: isLessThan,
            isGreaterThan: isGreaterThan,
            isGreaterThanOrEqualTo: isGreaterThanOrEqualTo,
            arrayContains: arrayContains,
            arrayContainsAny: arrayContainsAny,
            whereIn: whereIn,
            whereNotIn: whereNotIn,
            isNull: isNull,
          )
          .get();

      var map = querySnapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        data['id'] = doc.id;
        return data;
      }).toList();

      return map;
    } catch (e) {
      return [];
    }
  }
}
