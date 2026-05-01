class EnvConfig {
  final String environment;
  final String apiBaseUrl;
  final bool enableLogging;
  final bool enableAnalytics;

  const EnvConfig({
    required this.environment,
    required this.apiBaseUrl,
    required this.enableLogging,
    required this.enableAnalytics,
  });

  static EnvConfig dev() => const EnvConfig(
    environment: 'dev',
    apiBaseUrl: 'https://dev.api.bumbu.app',
    enableLogging: true,
    enableAnalytics: false,
  );

  static EnvConfig prod() => const EnvConfig(
    environment: 'prod',
    apiBaseUrl: 'https://api.bumbu.app',
    enableLogging: false,
    enableAnalytics: true,
  );
}
