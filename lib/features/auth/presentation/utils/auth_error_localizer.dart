import '../../../../core/errors/auth_exceptions.dart';
import '../../../../l10n/app_localizations.dart';

String localizeAuthError(AuthException e, AppLocalizations t) {
  switch (e.type) {
    case AuthErrorType.invalidCredential:
      return t.errorInvalidCredential;
    case AuthErrorType.invalidEmail:
      return t.errorInvalidEmail;
    case AuthErrorType.wrongPassword:
      return t.errorWrongPassword;
    case AuthErrorType.userNotFound:
      return t.errorUserNotFound;
    case AuthErrorType.emailAlreadyInUse:
      return t.errorEmailAlreadyUsed;
    case AuthErrorType.weakPassword:
      return t.errorWeakPassword;
    case AuthErrorType.network:
      return t.errorNetwork;
    case AuthErrorType.cancelled:
      return t.errorCancelled;
    case AuthErrorType.popupClosed:
      return t.errorPopupClosed;
    default:
      return t.errorUnknown;
  }
}
