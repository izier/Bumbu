class IndexingService {
  final Map<String, List<Map<String, dynamic>>> _index = {};

  void index(String key, List<Map<String, dynamic>> data) {
    _index[key] = data;
  }

  List<Map<String, dynamic>>? get(String key) {
    return _index[key];
  }
}
