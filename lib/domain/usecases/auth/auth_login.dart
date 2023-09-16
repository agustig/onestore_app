import 'package:dartz/dartz.dart';
import 'package:flutter_store_fic7/domain/entities/auth.dart';
import 'package:flutter_store_fic7/domain/repositories/auth_repository.dart';
import 'package:flutter_store_fic7/utils/failure.dart';

class AuthLogin {
  final AuthRepository repository;

  AuthLogin(this.repository);

  Future<Either<Failure, Auth>> execute({
    required String email,
    required String password,
  }) {
    return repository.login(email: email, password: password);
  }
}
