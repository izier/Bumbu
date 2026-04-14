// lib/core/models/app_error.dart

class AppError {
  final String message;
  final String? code;

  AppError({
    required this.message,
    this.code,
  });

  @override
  String toString() => message;
}
