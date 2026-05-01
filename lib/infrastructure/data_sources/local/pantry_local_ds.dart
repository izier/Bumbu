import 'cache_ds.dart';

class PantryLocalDataSource {
  final CacheDataSource cache;

  PantryLocalDataSource(this.cache);

  static const _box = 'pantry';

  Future<void> savePantry(String userId, List<Map<String, dynamic>> items) async {
    await cache.write(_box, userId, items);
  }

  Future<List<Map<String, dynamic>>?> getPantry(String userId) async {
    return await cache.read(_box, userId);
  }
}
