// lib/core/constants/app_constants.dart

class AppConstants {
  // Storage keys
  static const String pantryStorageKey = 'pantry_items';

  // Confidence decay rules (centralized)
  static const int highToMediumDays = 5;
  static const int mediumToLowDays = 10;

  // UI spacing (future consistency)
  static const double padding = 16.0;
  static const double radius = 12.0;

  // Images
  static const String logo = 'assets/images/logo.png';
  static const String logoWordmark = 'assets/images/logo with wordmark.png';
}
