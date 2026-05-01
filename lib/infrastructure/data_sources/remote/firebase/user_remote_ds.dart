import 'package:cloud_firestore/cloud_firestore.dart';

class UserRemoteDataSource {
  final FirebaseFirestore firestore;

  UserRemoteDataSource(this.firestore);

  Future<Map<String, dynamic>?> getUser(String id) async {
    final doc = await firestore.collection('users').doc(id).get();
    return doc.data();
  }
}
