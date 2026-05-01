class MemoryOptimizer {
  static void clearList<T>(List<T> list) {
    list.clear();
  }

  static void trimList<T>(List<T> list, int maxLength) {
    if (list.length > maxLength) {
      list.removeRange(0, list.length - maxLength);
    }
  }
}
