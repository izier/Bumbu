import 'exceptions.dart';
import 'failures.dart';

Failure mapExceptionToFailure(Exception e) {
  if (e is ServerException) {
    return const ServerFailure('Server error');
  } else if (e is CacheException) {
    return const CacheFailure('Cache error');
  } else if (e is NetworkException) {
    return const NetworkFailure('No internet connection');
  } else {
    return const ServerFailure('Unexpected error');
  }
}
