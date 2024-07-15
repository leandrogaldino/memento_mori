import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:memento_mori/interfaces/remote_db.dart';

class FirebaseFirestoreDB implements RemoteDB {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  @override
  Future<List<Map<String, dynamic>>> getStoriesGreaterThan({required int id}) async {
    try {
      QuerySnapshot querySnapshot = await _db.collection('stories').orderBy(FieldPath.documentId).startAfter([id.toString()]).get();
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

  @override
  Future<void> update({required String collection, required String documentid, required String field, required value}) async {
    await _db.collection(collection).doc(documentid).update({field: value});
  }
}
