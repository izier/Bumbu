// import '../../core/errors/exceptions.dart';
// import '../../features/recipe/domain/entities/recipe.dart';
// import '../../features/recipe/domain/repositories/recipe_repository.dart';
// import '../data_sources/remote/firebase/recipe_remote_ds.dart';
// import '../data_sources/local/recipe_local_ds.dart';
// import '../mappers/recipe_mapper.dart';
//
// class RecipeRepositoryImpl implements RecipeRepository {
//   final RecipeRemoteDataSource remote;
//   final RecipeLocalDataSource local;
//
//   RecipeRepositoryImpl({
//     required this.remote,
//     required this.local,
//   });
//
//   @override
//   Future<Recipe> getRecipe(String id) async {
//     try {
//       final remoteData = await remote.getRecipe(id);
//
//       if (remoteData != null) {
//         await local.cacheRecipe(id, remoteData);
//         return RecipeMapper.fromMap(remoteData);
//       }
//
//       final localData = await local.getRecipe(id);
//
//       if (localData != null) {
//         return RecipeMapper.fromMap(localData);
//       }
//
//       throw CacheException();
//     } catch (_) {
//       throw ServerException();
//     }
//   }
// }
