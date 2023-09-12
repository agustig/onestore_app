import 'package:dartz/dartz.dart';
import 'package:flutter_store_fic7/domain/repositories/auth_repository.dart';
import 'package:flutter_store_fic7/utils/failure.dart';

class AuthGetToken {
  final AuthRepository repository;

  AuthGetToken(this.repository);

  Future<Either<Failure, String?>> execute() {
    return repository.getAuthToken();
  }
}
