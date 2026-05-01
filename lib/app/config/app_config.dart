import 'env_config.dart';
import 'feature_flags.dart';

class AppConfig {
  static late EnvConfig env;
  static late FeatureFlags features;

  static Future<void> initialize() async {
    const isProd = bool.fromEnvironment('dart.vm.product');

    env = isProd ? EnvConfig.prod() : EnvConfig.dev();
    features = FeatureFlags.defaultFlags();
  }
}
