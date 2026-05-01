import '../../../../../core/base/entity.dart';

class AppUser extends Entity {
  final String id;
  final String email;

  const AppUser({
    required this.id,
    required this.email,
  });
}
