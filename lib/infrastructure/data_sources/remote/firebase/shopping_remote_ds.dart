import 'package:cloud_firestore/cloud_firestore.dart';

class ShoppingRemoteDataSource {
  final FirebaseFirestore firestore;

  ShoppingRemoteDataSource(this.firestore);

  Future<List<Map<String, dynamic>>> getShoppingList(String userId) async {
    final snapshot = await firestore
        .collection('shopping_lists')
        .doc(userId)
        .collection('items')
        .get();

    return snapshot.docs.map((e) => e.data()).toList();
  }

  Future<void> updateItem(
    String userId,
    String itemId,
    Map<String, dynamic> data,
  ) async {
    await firestore
        .collection('shopping_lists')
        .doc(userId)
        .collection('items')
        .doc(itemId)
        .set(data);
  }

  Future<void> deleteItem(String userId, String itemId) async {
    await firestore
        .collection('shopping_lists')
        .doc(userId)
        .collection('items')
        .doc(itemId)
        .delete();
  }
}
