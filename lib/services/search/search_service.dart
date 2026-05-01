class SearchService {
  Future<List<Map<String, dynamic>>> search(
      String query,
      List<Map<String, dynamic>> source,
      ) async {
    return source
        .where((item) =>
        item.toString().toLowerCase().contains(query.toLowerCase()))
        .toList();
  }
}
