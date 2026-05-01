import '../../../../core/base/usecase.dart';
import '../repositories/auth_repository.dart';

class SignOut implements UseCase<void, NoParams> {
  final AuthRepository repository;

  SignOut(this.repository);

  @override
  Future<void> call(NoParams params) {
    return repository.signOut();
  }
}
