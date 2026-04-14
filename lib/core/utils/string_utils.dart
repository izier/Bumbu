// lib/core/utils/string_utils.dart

class StringUtils {
  static String normalize(String input) {
    return input.trim().toLowerCase();
  }

  static String capitalize(String input) {
    if (input.isEmpty) return input;
    return input[0].toUpperCase() + input.substring(1);
  }
}
