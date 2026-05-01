abstract class LocalStorage {
  Future<void> write(String key, dynamic value);
  T? read<T>(String key);
  Future<void> delete(String key);
}
