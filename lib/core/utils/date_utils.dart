// lib/core/utils/date_utils.dart

class DateUtilsHelper {
  static int daysBetween(DateTime from, DateTime to) {
    return to.difference(from).inDays;
  }

  static bool isOlderThan(DateTime date, int days) {
    final now = DateTime.now();
    return now.difference(date).inDays > days;
  }
}
