import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../../../../core/firestore/users_public_sync.dart';
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
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final Ref _ref;
  StreamSubscription<User?>? _authSubscription;
  bool _isInitializing = false;
  Completer<void>? _syncTask;

  void _init() {
    _authSubscription = _auth.authStateChanges().listen((user) async {
      if (_isInitializing) return;
      _isInitializing = true;

      try {
        if (kIsWeb) await Future.delayed(const Duration(milliseconds: 500));
        
        // Wait for any existing refresh/sync task to complete
        if (_syncTask != null) await _syncTask!.future;
        _syncTask = Completer<void>();

        if (user == null) {
          state = null;
        } else {
          final docRef = _firestore.collection('users').doc(user.uid);
          final doc = await docRef.get();
          
          Map<String, dynamic>? data;
          if (!doc.exists) {
            data = await _createInitialUserDocument(user);
          } else {
            data = doc.data();
          }

          if (!mounted) return;

          state = AppUser(
            id: user.uid,
            email: user.email ?? '',
            username: data?['username']?.toString() ?? '',
            displayName: data?['displayName']?.toString() ?? user.displayName ?? '',
          );
          unawaited(UsersPublicSync.mergeFromPrivateMap(user.uid, data));
        }
      } catch (e, st) {
        Logger.error('Auth state change error', e, st);
      } finally {
        _syncTask?.complete();
        _syncTask = null;
        _isInitializing = false;
      }
    });
  }

  Future<Map<String, dynamic>> _createInitialUserDocument(User user) async {
    final doc = _firestore.collection('users').doc(user.uid);
    final email = user.email ?? '';
    final fallbackUsername = email.contains('@')
        ? email.split('@').first
        : 'user${user.uid.substring(0, 6)}';

    final payload = {
      'email': email,
      'username': fallbackUsername.toLowerCase(),
      'displayName': user.displayName ?? fallbackUsername,
      'createdAt': FieldValue.serverTimestamp(),
    };

    await doc.set(payload);
    return payload;
  }

  Future<void> logout() async {
    await _auth.signOut();
    _ref.invalidate(signInStateProvider);
  }

  /// Re-read Firestore profile after local edits.
  Future<void> refreshProfile() async {
    final user = _auth.currentUser;
    if (user == null) return;

    if (_syncTask != null) await _syncTask!.future;
    _syncTask = Completer<void>();

    try {
      final docRef = _firestore.collection('users').doc(user.uid);
      final doc = await docRef.get();

      Map<String, dynamic>? data;
      if (!doc.exists) {
        data = await _createInitialUserDocument(user);
      } else {
        data = doc.data();
      }

      state = AppUser(
        id: user.uid,
        email: user.email ?? '',
        username: data?['username']?.toString() ?? '',
        displayName: data?['displayName']?.toString() ?? user.displayName ?? '',
      );
      unawaited(UsersPublicSync.mergeFromPrivateMap(user.uid, data));
    } finally {
      _syncTask?.complete();
      _syncTask = null;
    }
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
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> signInEmail(String identifier, String password) async {
    state = const AsyncLoading();
    try {
      final email = await _emailForIdentifier(identifier);
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

  Future<void> registerEmail({
    required String email,
    required String password,
    required String username,
    required String displayName,
  }) async {
    state = const AsyncLoading();
    User? createdUser;
    try {
      if (!email.contains('@')) {
        throw const AuthException(AuthErrorType.invalidEmail);
      }

      if (password.length < 6) {
        throw const AuthException(AuthErrorType.weakPassword);
      }

      final normalizedUsername = username.trim().toLowerCase();
      if (normalizedUsername.length < 3 || normalizedUsername.contains('@')) {
        throw const AuthException(AuthErrorType.invalidCredential);
      }

      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      createdUser = credential.user;
      if (createdUser == null) {
        throw const AuthException(AuthErrorType.unknown);
      }

      // Check username while authenticated so Firestore rules can allow the query.
      final usernameTaken = await _firestore
          .collection(UsersPublicSync.collection)
          .where('username', isEqualTo: normalizedUsername)
          .limit(1)
          .get();
      if (usernameTaken.docs.isNotEmpty) {
        await createdUser.delete();
        throw const AuthException(AuthErrorType.usernameAlreadyInUse);
      }

      final trimmedDisplay = displayName.trim();
      final resolvedDisplay =
          trimmedDisplay.isEmpty ? normalizedUsername : trimmedDisplay;
      await createdUser.updateDisplayName(resolvedDisplay);
      final privateUser = {
        'email': email,
        'username': normalizedUsername,
        'displayName': resolvedDisplay,
        'createdAt': FieldValue.serverTimestamp(),
      };
      await _firestore.collection('users').doc(createdUser.uid).set(privateUser);
      await UsersPublicSync.mergeFromPrivateMap(createdUser.uid, privateUser);
      state = const AsyncData(null);
    } on AuthException catch (e, st) {
      state = AsyncError(e, st);
    } catch (e, st) {
      Logger.error('Auth register failed', e, st);
      try {
        await createdUser?.delete();
      } catch (_) {}
      state = AsyncError(_mapRegistrationError(e), st);
    }
  }

  AuthException _mapRegistrationError(Object e) {
    if (e is FirebaseAuthException) {
      return mapFirebaseAuthException(e);
    }
    if (e is FirebaseException) {
      switch (e.code) {
        case 'permission-denied':
        case 'unavailable':
          return const AuthException(AuthErrorType.network);
        default:
          return const AuthException(AuthErrorType.unknown);
      }
    }
    return mapFirebaseAuthException(e);
  }

  Future<String> _emailForIdentifier(String identifier) async {
    final value = identifier.trim();
    if (value.contains('@')) return value;

    final snapshot = await _firestore
        .collection(UsersPublicSync.collection)
        .where('username', isEqualTo: value.toLowerCase())
        .limit(1)
        .get();
    if (snapshot.docs.isEmpty) {
      throw const AuthException(AuthErrorType.userNotFound);
    }
    return snapshot.docs.first.data()['email']?.toString() ?? '';
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
