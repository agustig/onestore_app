import 'package:dartz/dartz.dart';
import 'package:onestore_app/domain/repositories/auth_repository.dart';
import 'package:onestore_app/utils/failure.dart';

class AuthGetToken {
  final AuthRepository repository;

  AuthGetToken(this.repository);

  Future<Either<Failure, String?>> execute() {
    return repository.getAuthToken();
  }
}
