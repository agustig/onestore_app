import 'package:dartz/dartz.dart';
import 'package:onestore_app/domain/repositories/auth_repository.dart';
import 'package:onestore_app/utils/failure.dart';

class AuthSaveToken {
  final AuthRepository repository;

  AuthSaveToken(this.repository);

  Future<Either<Failure, bool>> execute(String authToken) {
    return repository.saveAuthToken(authToken);
  }
}
