// import '../../features/social/domain/repositories/social_repository.dart';
// import '../data_sources/remote/firebase/social_remote_ds.dart';
//
// class SocialRepositoryImpl implements SocialRepository {
//   final SocialRemoteDataSource remote;
//
//   SocialRepositoryImpl(this.remote);
//
//   @override
//   Future<void> createPost(Map<String, dynamic> data) async {
//     await remote.createPost(data);
//   }
//
//   @override
//   Future<void> likePost(String postId, String userId) async {
//     await remote.likePost(postId, userId);
//   }
//
//   @override
//   Future<void> commentPost(
//       String postId,
//       Map<String, dynamic> data,
//       ) async {
//     await remote.commentPost(postId, data);
//   }
//
//   @override
//   Future<List<Map<String, dynamic>>> getPosts() async {
//     return await remote.getPosts();
//   }
// }
