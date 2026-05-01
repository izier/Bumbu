import 'package:cloud_firestore/cloud_firestore.dart';

class PersonalizationRemoteDataSource {
  final FirebaseFirestore firestore;

  PersonalizationRemoteDataSource(this.firestore);

  Future<Map<String, dynamic>?> getPreferences(String userId) async {
    final doc = await firestore.collection('preferences').doc(userId).get();
    return doc.data();
  }

  Future<void> updatePreferences(
    String userId,
    Map<String, dynamic> data,
  ) async {
    await firestore.collection('preferences').doc(userId).set(data);
  }
}
