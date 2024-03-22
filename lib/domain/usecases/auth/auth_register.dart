import 'package:dartz/dartz.dart';
import 'package:onestore_app/domain/entities/auth.dart';
import 'package:onestore_app/domain/repositories/auth_repository.dart';
import 'package:onestore_app/utils/failure.dart';

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
