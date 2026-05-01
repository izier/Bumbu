import 'package:cloud_firestore/cloud_firestore.dart';

class PantryRemoteDataSource {
  final FirebaseFirestore firestore;

  PantryRemoteDataSource(this.firestore);

  Future<List<Map<String, dynamic>>> getPantry(String userId) async {
    final snapshot = await firestore
        .collection('pantry')
        .doc(userId)
        .collection('items')
        .get();

    return snapshot.docs.map((e) => e.data()).toList();
  }
}
