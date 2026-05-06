import 'package:firebase_auth/firebase_auth.dart';
import 'auth_exceptions.dart';

AuthException mapFirebaseAuthException(Object e) {
  if (e is AuthException) return e;

  // Firebase errors
  if (e is FirebaseAuthException) {
    switch (e.code) {
      case 'invalid-email':
        return const AuthException(AuthErrorType.invalidEmail);
      case 'wrong-password':
        return const AuthException(AuthErrorType.wrongPassword);
      case 'user-not-found':
        return const AuthException(AuthErrorType.userNotFound);
      case 'invalid-credential':
        return const AuthException(AuthErrorType.invalidCredential);
      case 'email-already-in-use':
        return const AuthException(AuthErrorType.emailAlreadyInUse);
      case 'weak-password':
        return const AuthException(AuthErrorType.weakPassword);
      case 'network-request-failed':
        return const AuthException(AuthErrorType.network);
      case 'popup-closed-by-user':
        return const AuthException(AuthErrorType.popupClosed);
    }
  }

  // 🔑 STRING-BASED fallback (VERY IMPORTANT FOR WEB)
  final message = e.toString().toLowerCase();

  if (message.contains('invalid-credential')) {
    return const AuthException(AuthErrorType.invalidCredential);
  }

  if (message.contains('invalid-email')) {
    return const AuthException(AuthErrorType.invalidEmail);
  }
  if (message.contains('wrong-password')) {
    return const AuthException(AuthErrorType.wrongPassword);
  }
  if (message.contains('user-not-found')) {
    return const AuthException(AuthErrorType.userNotFound);
  }
  if (message.contains('email-already-in-use')) {
    return const AuthException(AuthErrorType.emailAlreadyInUse);
  }
  if (message.contains('weak-password')) {
    return const AuthException(AuthErrorType.weakPassword);
  }
  if (message.contains('network')) {
    return const AuthException(AuthErrorType.network);
  }
  if (message.contains('popup') || message.contains('closed')) {
    return const AuthException(AuthErrorType.popupClosed);
  }
  if (message.contains('cancel')) {
    return const AuthException(AuthErrorType.cancelled);
  }

  return const AuthException(AuthErrorType.unknown);
}
