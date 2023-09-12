import 'package:dartz/dartz.dart';
import 'package:flutter_store_fic7/domain/repositories/auth_repository.dart';
import 'package:flutter_store_fic7/utils/failure.dart';

class AuthRemoveToken {
  final AuthRepository repository;

  AuthRemoveToken(this.repository);

  Future<Either<Failure, bool>> execute() {
    return repository.removeAuthToken();
  }
}
