import 'package:cloud_firestore/cloud_firestore.dart';
import 'firebase_service.dart';

class FirestoreService {
  final _db = FirebaseService.firestore;

  Future<DocumentSnapshot<Map<String, dynamic>>> getDoc(
      String collection,
      String id,
      ) {
    return _db.collection(collection).doc(id).get();
  }

  Future<void> setDoc(
      String collection,
      String id,
      Map<String, dynamic> data,
      ) {
    return _db.collection(collection).doc(id).set(data);
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getCollection(
      String collection, {
        int limit = 20,
      }) {
    return _db.collection(collection).limit(limit).get();
  }
}
