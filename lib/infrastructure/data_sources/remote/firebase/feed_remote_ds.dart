import 'package:cloud_firestore/cloud_firestore.dart';

class FeedRemoteDataSource {
  final FirebaseFirestore firestore;

  FeedRemoteDataSource(this.firestore);

  Future<List<Map<String, dynamic>>> getFeed() async {
    final snapshot = await firestore.collection('home').limit(20).get();

    return snapshot.docs.map((e) => e.data()).toList();
  }
}
