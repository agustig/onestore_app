import 'package:dartz/dartz.dart';
import 'package:flutter_store_fic7/domain/entities/auth.dart';
import 'package:flutter_store_fic7/domain/repositories/auth_repository.dart';
import 'package:flutter_store_fic7/utils/failure.dart';

class AuthRegister {
  final AuthRepository repository;

  AuthRegister(this.repository);

  Future<Either<Failure, Auth>> execute({
    required String name,
    required String email,
    required String password,
    required String passwordConfirmation,
  }) {
    return repository.register(
      name: name,
      email: email,
      password: password,
      passwordConfirmation: passwordConfirmation,
    );
  }
}
