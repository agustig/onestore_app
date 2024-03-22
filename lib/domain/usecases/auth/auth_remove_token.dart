import 'package:dartz/dartz.dart';
import 'package:onestore_app/domain/repositories/auth_repository.dart';
import 'package:onestore_app/utils/failure.dart';

class AuthRemoveToken {
  final AuthRepository repository;

  AuthRemoveToken(this.repository);

  Future<Either<Failure, bool>> execute() {
    return repository.removeAuthToken();
  }
}
