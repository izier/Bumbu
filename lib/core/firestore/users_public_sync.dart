import 'package:cloud_firestore/cloud_firestore.dart';

/// Keeps `users_public/{uid}` in sync with searchable fields from `users/{uid}`.
/// Matches rules: public collection readable by any signed-in user for search.
class UsersPublicSync {
  UsersPublicSync._();

  static const collection = 'users_public';

  static Future<void> mergeFromPrivateMap(
    String uid,
    Map<String, dynamic>? private,
  ) async {
    if (private == null) return;
    final username = private['username']?.toString() ?? '';
    final displayName = private['displayName']?.toString() ?? '';
    final email = private['email']?.toString() ?? '';
    await FirebaseFirestore.instance.collection(collection).doc(uid).set({
      'username': username,
      'displayName': displayName,
      'email': email,
      'updatedAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }

  static Future<void> mergeFields({
    required String uid,
    required String username,
    required String displayName,
    required String email,
  }) async {
    await FirebaseFirestore.instance.collection(collection).doc(uid).set({
      'username': username,
      'displayName': displayName,
      'email': email,
      'updatedAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }
}
