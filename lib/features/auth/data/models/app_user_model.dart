import '../../domain/entities/app_user.dart';

class AppUserModel extends AppUser {
  const AppUserModel({
    required super.id,
    required super.email,
    super.username,
    super.displayName,
  });

  factory AppUserModel.fromFirebaseUser(dynamic user) {
    return AppUserModel(
      id: user.uid,
      email: user.email ?? '',
      username: '',
      displayName: user.displayName ?? '',
    );
  }

  factory AppUserModel.fromMap(String id, Map<String, dynamic> map) {
    return AppUserModel(
      id: id,
      email: map['email']?.toString() ?? '',
      username: map['username']?.toString() ?? '',
      displayName: map['displayName']?.toString() ?? '',
    );
  }
}
