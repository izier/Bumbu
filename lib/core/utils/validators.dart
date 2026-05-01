class Validators {
  static bool isNotEmpty(String? value) {
    return value != null && value.trim().isNotEmpty;
  }

  static bool isValidUrl(String value) {
    final uri = Uri.tryParse(value);
    return uri != null && uri.hasAbsolutePath;
  }
}
