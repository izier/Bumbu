import 'package:hive/hive.dart';

class CacheDataSource {
  Future<Box> _openBox(String name) async {
    return Hive.openBox(name);
  }

  Future<void> write(String box, String key, dynamic value) async {
    final b = await _openBox(box);
    await b.put(key, value);
  }

  Future<T?> read<T>(String box, String key) async {
    final b = await _openBox(box);
    return b.get(key) as T?;
  }

  Future<void> delete(String box, String key) async {
    final b = await _openBox(box);
    await b.delete(key);
  }
}
