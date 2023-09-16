import 'package:dartz/dartz.dart';
import 'package:flutter_store_fic7/domain/repositories/auth_repository.dart';
import 'package:flutter_store_fic7/utils/failure.dart';

class AuthSaveToken {
  final AuthRepository repository;

  AuthSaveToken(this.repository);

  Future<Either<Failure, bool>> execute(String authToken) {
    return repository.saveAuthToken(authToken);
  }
}
