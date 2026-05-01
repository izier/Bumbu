// lib/features/auth/domain/usecases/sign_up.dart
import '../../../../core/base/usecase.dart';
import '../entities/app_user.dart';
import '../repositories/auth_repository.dart';

class SignUp implements UseCase<AppUser?, SignUpParams> {
  final AuthRepository repository;

  SignUp(this.repository);

  @override
  Future<AppUser?> call(SignUpParams params) {
    return repository.signUp(params.email, params.password);
  }
}

class SignUpParams {
  final String email;
  final String password;

  SignUpParams({
    required this.email,
    required this.password,
  });
}
