// import '../../features/shopping/domain/repositories/shopping_repository.dart';
// import '../data_sources/remote/firebase/shopping_remote_ds.dart';
//
// class ShoppingRepositoryImpl implements ShoppingRepository {
//   final ShoppingRemoteDataSource remote;
//
//   ShoppingRepositoryImpl(this.remote);
//
//   @override
//   Future<List<Map<String, dynamic>>> getShoppingList(String userId) async {
//     return await remote.getShoppingList(userId);
//   }
//
//   @override
//   Future<void> updateItem(
//       String userId,
//       String itemId,
//       Map<String, dynamic> data,
//       ) async {
//     await remote.updateItem(userId, itemId, data);
//   }
//
//   @override
//   Future<void> deleteItem(String userId, String itemId) async {
//     await remote.deleteItem(userId, itemId);
//   }
// }
