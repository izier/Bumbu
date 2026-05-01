class FeatureFlags {
  final bool enableAIParsing;
  final bool enableSocialFeed;
  final bool enablePantry;
  final bool enableShopping;
  final bool enableCookingMode;
  final bool enablePersonalization;

  const FeatureFlags({
    required this.enableAIParsing,
    required this.enableSocialFeed,
    required this.enablePantry,
    required this.enableShopping,
    required this.enableCookingMode,
    required this.enablePersonalization,
  });

  factory FeatureFlags.defaultFlags() {
    return const FeatureFlags(
      enableAIParsing: true,
      enableSocialFeed: true,
      enablePantry: true,
      enableShopping: true,
      enableCookingMode: true,
      enablePersonalization: true,
    );
  }
}
