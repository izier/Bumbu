import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import '../../domain/entities/app_user.dart';
import '../../../../core/errors/auth_exceptions.dart';
import '../../../../core/errors/auth_error_mapper.dart';

// ── 1. Auth state — only ever null (logged out) or an AppUser (logged in) ──

final authStateProvider = StateNotifierProvider<AuthNotifier, AppUser?>((ref) {
  return AuthNotifier(ref);
});

class AuthNotifier extends StateNotifier<AppUser?> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Ref _ref;

  AuthNotifier(this._ref) : super(null) {
    _init();
  }

  Future<void> _init() async {
    _auth.authStateChanges().listen((user) {
      if (user == null) {
        state = null;
      } else {
        state = AppUser(id: user.uid, email: user.email ?? '');
      }
    });
  }

  Future<void> logout() async {
    await _auth.signOut();
    // Invalidate sign-in state so the next session starts clean.
    _ref.invalidate(signInStateProvider);
  }
}

// ── 2. Sign-in state — owned by the auth page, invisible to the router ──────

final signInStateProvider =
StateNotifierProvider<SignInNotifier, AsyncValue<void>>((ref) {
  return SignInNotifier(ref);
});

class SignInNotifier extends StateNotifier<AsyncValue<void>> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  SignInNotifier(Ref ref) : super(const AsyncData(null));

  // ---------------- EMAIL LOGIN ----------------
  Future<void> signInEmail(String email, String password) async {
    state = const AsyncLoading();
    try {
      if (!email.contains('@')) {
        throw const AuthException(AuthErrorType.invalidEmail);
      }

      if (password.length < 6) {
        throw const AuthException(AuthErrorType.weakPassword);
      }

      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      state = const AsyncData(null);
    } catch (e, st) {
      print('AUTH ERROR: $e');
      state = AsyncError(mapFirebaseAuthException(e), st);
    }
  }

  // ---------------- REGISTER ----------------
  Future<void> registerEmail(String email, String password) async {
    state = const AsyncLoading();
    try {
      if (!email.contains('@')) {
        throw const AuthException(AuthErrorType.invalidEmail);
      }

      if (password.length < 6) {
        throw const AuthException(AuthErrorType.weakPassword);
      }

      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      state = const AsyncData(null);
    } catch (e, st) {
      state = AsyncError(mapFirebaseAuthException(e), st);
    }
  }

  // ---------------- GOOGLE ----------------
  Future<void> signInGoogle() async {
    state = const AsyncLoading();
    try {
      if (kIsWeb) {
        final provider = GoogleAuthProvider();
        await _auth.signInWithPopup(provider);
      } else {
        final googleSignIn = GoogleSignIn.instance;
        await googleSignIn.initialize();

        try {
          final account = await googleSignIn.authenticate();
          final auth = account.authentication;
          final credential = GoogleAuthProvider.credential(
            idToken: auth.idToken,
          );
          await _auth.signInWithCredential(credential);
        } catch (_) {
          throw const AuthException(AuthErrorType.cancelled);
        }
      }
      state = const AsyncData(null);
    } catch (e, st) {
      state = AsyncError(mapFirebaseAuthException(e), st);
    }
  }

  // ---------------- APPLE ----------------
  Future<void> signInApple() async {
    state = const AsyncLoading();
    try {
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      final oauthCredential = OAuthProvider('apple.com').credential(
        idToken: appleCredential.identityToken,
        accessToken: appleCredential.authorizationCode,
      );

      await _auth.signInWithCredential(oauthCredential);
      state = const AsyncData(null);
    } on SignInWithAppleAuthorizationException catch (e, st) {
      if (e.code == AuthorizationErrorCode.canceled) {
        state = const AsyncData(null);
      } else {
        state = AsyncError(e, st);
      }
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  /// Call from the auth page to clear a previous error before retrying.
  void clearError() => state = const AsyncData(null);
}