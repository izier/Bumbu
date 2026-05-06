enum AuthErrorType {
  invalidEmail,
  wrongPassword,
  userNotFound,
  emailAlreadyInUse,
  usernameAlreadyInUse,
  weakPassword,
  network,
  cancelled,
  popupClosed,
  invalidCredential,
  unknown,
}

class AuthException implements Exception {
  final AuthErrorType type;
  const AuthException(this.type);
}
