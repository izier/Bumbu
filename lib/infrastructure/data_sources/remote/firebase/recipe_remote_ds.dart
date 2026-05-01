import 'package:cloud_firestore/cloud_firestore.dart';

class RecipeRemoteDataSource {
  final FirebaseFirestore firestore;

  RecipeRemoteDataSource(this.firestore);

  Future<Map<String, dynamic>?> getRecipe(String id) async {
    final doc = await firestore.collection('recipes').doc(id).get();
    return doc.data();
  }

  Future<void> saveRecipe(String id, Map<String, dynamic> data) async {
    await firestore.collection('recipes').doc(id).set(data);
  }
}
