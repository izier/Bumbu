import 'package:firebase_auth/firebase_auth.dart';
import '../../features/auth/domain/entities/app_user.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/data/models/app_user_model.dart';
import '../data_sources/remote/firebase/auth_remote_ds.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remote;

  AuthRepositoryImpl(this.remote);

  @override
  Future<AppUser?> signIn(String email, String password) async {
    final User? user = await remote.signIn(email, password);
    if (user == null) return null;

    return AppUserModel.fromFirebaseUser(user);
  }

  @override
  Future<AppUser?> signUp(String email, String password) async {
    final User? user = await remote.signUp(email, password);
    if (user == null) return null;

    return AppUserModel.fromFirebaseUser(user);
  }

  @override
  Future<void> signOut() async {
    await remote.signOut();
  }

  @override
  AppUser? getCurrentUser() {
    final user = remote.getCurrentUser();
    if (user == null) return null;

    return AppUserModel.fromFirebaseUser(user);
  }
}
