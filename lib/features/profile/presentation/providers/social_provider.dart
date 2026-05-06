import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/firestore/users_public_sync.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../../domain/entities/user_profile.dart';

/// Searchable public profiles (`users_public`). Private data stays in `users`.
final userProfilesProvider = FutureProvider<List<UserProfile>>((ref) async {
  final user = ref.watch(authStateProvider);
  if (user == null) return const [];

  final snapshot = await FirebaseFirestore.instance
      .collection(UsersPublicSync.collection)
      .limit(80)
      .get();
  return snapshot.docs
      .map((doc) => UserProfile.fromMap(doc.id, doc.data()))
      .toList();
});

String followDocId({required String followerId, required String followingId}) {
  return '${followerId}_$followingId';
}

class SocialService {
  const SocialService();

  Stream<bool> isFollowing({
    required String followerId,
    required String followingId,
  }) {
    return FirebaseFirestore.instance
        .collection('follows')
        .doc(followDocId(followerId: followerId, followingId: followingId))
        .snapshots()
        .map((doc) => doc.exists);
  }

  Future<void> toggleFollow({
    required String followerId,
    required String followingId,
    required bool currentlyFollowing,
  }) async {
    final doc = FirebaseFirestore.instance
        .collection('follows')
        .doc(followDocId(followerId: followerId, followingId: followingId));

    if (currentlyFollowing) {
      await doc.delete();
      return;
    }

    await doc.set({
      'followerId': followerId,
      'followingId': followingId,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  Future<List<UserProfile>> getFollowers(String userId) async {
    final snapshot = await FirebaseFirestore.instance
        .collection('follows')
        .where('followingId', isEqualTo: userId)
        .orderBy('createdAt', descending: true)
        .get();

    if (snapshot.docs.isEmpty) return [];

    final userIds = snapshot.docs.map((doc) => doc.get('followerId') as String).toList();
    
    // Firestore "in" query limited to 30 items. For a full app, we'd batch this or use a different sync strategy.
    final usersSnapshot = await FirebaseFirestore.instance
        .collection(UsersPublicSync.collection)
        .where(FieldPath.documentId, whereIn: userIds.take(30).toList())
        .get();

    return usersSnapshot.docs
        .map((doc) => UserProfile.fromMap(doc.id, doc.data()))
        .toList();
  }

  Future<List<UserProfile>> getFollowing(String userId) async {
    final snapshot = await FirebaseFirestore.instance
        .collection('follows')
        .where('followerId', isEqualTo: userId)
        .orderBy('createdAt', descending: true)
        .get();

    if (snapshot.docs.isEmpty) return [];

    final userIds = snapshot.docs.map((doc) => doc.get('followingId') as String).toList();
    
    final usersSnapshot = await FirebaseFirestore.instance
        .collection(UsersPublicSync.collection)
        .where(FieldPath.documentId, whereIn: userIds.take(30).toList())
        .get();

    return usersSnapshot.docs
        .map((doc) => UserProfile.fromMap(doc.id, doc.data()))
        .toList();
  }
}

final socialServiceProvider = Provider((ref) => const SocialService());

final isFollowingProvider = StreamProvider.family<bool, ({String followerId, String followingId})>((ref, arg) {
  return ref.watch(socialServiceProvider).isFollowing(
    followerId: arg.followerId,
    followingId: arg.followingId,
  );
});

final userStatsProvider = StreamProvider.family<({int followers, int following}), String>((ref, userId) {
  return FirebaseFirestore.instance
      .collection('follows')
      .where('followingId', isEqualTo: userId)
      .snapshots()
      .asyncMap((snapshot) async {
    final followersCount = snapshot.docs.length;
    try {
      final following = await FirebaseFirestore.instance
          .collection('follows')
          .where('followerId', isEqualTo: userId)
          .count()
          .get();
      return (followers: followersCount, following: following.count ?? 0);
    } catch (e) {
      return (followers: followersCount, following: 0);
    }
  });
});

final followersProvider = FutureProvider.family<List<UserProfile>, String>((ref, userId) {
  return ref.watch(socialServiceProvider).getFollowers(userId);
});

final followingProvider = FutureProvider.family<List<UserProfile>, String>((ref, userId) {
  return ref.watch(socialServiceProvider).getFollowing(userId);
});
