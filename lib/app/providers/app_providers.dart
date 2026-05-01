import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../config/app_config.dart';

final appConfigProvider = Provider((ref) => AppConfig.env);

final featureFlagsProvider = Provider((ref) => AppConfig.features);
