import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../../../../core/errors/auth_error_mapper.dart';
import '../../../../core/errors/auth_exceptions.dart';
import '../../../../core/utils/logger.dart';
import '../../domain/entities/app_user.dart';

final authStateProvider = StateNotifierProvider<AuthNotifier, AppUser?>((ref) {
  return AuthNotifier(ref);
});

class AuthNotifier extends StateNotifier<AppUser?> {
  AuthNotifier(this._ref) : super(null) {
    _init();
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Ref _ref;
  StreamSubscription<User?>? _authSubscription;

  void _init() {
    _authSubscription = _auth.authStateChanges().listen((user) {
      if (user == null) {
        state = null;
      } else {
        state = AppUser(id: user.uid, email: user.email ?? '');
      }
    });
  }

  Future<void> logout() async {
    await _auth.signOut();
    _ref.invalidate(signInStateProvider);
  }

  @override
  void dispose() {
    _authSubscription?.cancel();
    super.dispose();
  }
}

final signInStateProvider =
    StateNotifierProvider<SignInNotifier, AsyncValue<void>>((ref) {
      return SignInNotifier(ref);
    });

class SignInNotifier extends StateNotifier<AsyncValue<void>> {
  SignInNotifier(Ref _) : super(const AsyncData(null));

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> signInEmail(String email, String password) async {
    state = const AsyncLoading();
    try {
      if (!email.contains('@')) {
        throw const AuthException(AuthErrorType.invalidEmail);
      }

      if (password.length < 6) {
        throw const AuthException(AuthErrorType.weakPassword);
      }

      await _auth.signInWithEmailAndPassword(email: email, password: password);
      state = const AsyncData(null);
    } catch (e, st) {
      Logger.error('Auth sign-in failed', e, st);
      state = AsyncError(mapFirebaseAuthException(e), st);
    }
  }

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

  void clearError() => state = const AsyncData(null);
}
