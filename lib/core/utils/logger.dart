import 'package:flutter/foundation.dart';

class Logger {
  const Logger._();

  static bool get enabled => kDebugMode;

  static void log(String message) {
    if (!enabled) return;
    debugPrint('[LOG] $message');
  }

  static void error(String message, [Object? error, StackTrace? stackTrace]) {
    if (!enabled) return;

    debugPrint('[ERROR] $message');
    if (error != null) {
      debugPrint('$error');
    }
    if (stackTrace != null) {
      debugPrintStack(stackTrace: stackTrace);
    }
  }
}
