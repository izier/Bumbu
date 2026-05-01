import '../../domain/entities/app_user.dart';

class AppUserModel extends AppUser {
  const AppUserModel({
    required super.id,
    required super.email,
  });

  factory AppUserModel.fromFirebaseUser(dynamic user) {
    return AppUserModel(
      id: user.uid,
      email: user.email ?? '',
    );
  }
}
