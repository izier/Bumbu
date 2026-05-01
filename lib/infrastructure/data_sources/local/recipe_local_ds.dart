import 'cache_ds.dart';

class RecipeLocalDataSource {
  final CacheDataSource cache;

  RecipeLocalDataSource(this.cache);

  static const _box = 'recipes';

  Future<void> cacheRecipe(String id, Map<String, dynamic> data) async {
    await cache.write(_box, id, data);
  }

  Future<Map<String, dynamic>?> getRecipe(String id) async {
    return await cache.read(_box, id);
  }
}
