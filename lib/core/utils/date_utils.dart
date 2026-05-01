class AppDateUtils {
  static DateTime now() => DateTime.now();

  static String format(DateTime date) {
    return '${date.year}-${date.month}-${date.day}';
  }
}
