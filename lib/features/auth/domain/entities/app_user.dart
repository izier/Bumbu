import '../../../../../core/base/entity.dart';

class AppUser extends Entity {
  final String id;
  final String email;
  final String username;
  final String displayName;

  const AppUser({
    required this.id,
    required this.email,
    this.username = '',
    this.displayName = '',
  });
}
