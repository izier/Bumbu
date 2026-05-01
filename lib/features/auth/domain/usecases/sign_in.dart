// lib/features/auth/domain/usecases/sign_in.dart
import '../../../../core/base/usecase.dart';
import '../entities/app_user.dart';
import '../repositories/auth_repository.dart';

class SignIn implements UseCase<AppUser?, SignInParams> {
  final AuthRepository repository;

  SignIn(this.repository);

  @override
  Future<AppUser?> call(SignInParams params) {
    return repository.signIn(params.email, params.password);
  }
}

class SignInParams {
  final String email;
  final String password;

  SignInParams({
    required this.email,
    required this.password,
  });
}
