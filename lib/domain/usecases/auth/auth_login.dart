import 'package:dartz/dartz.dart';
import 'package:onestore_app/domain/entities/auth.dart';
import 'package:onestore_app/domain/repositories/auth_repository.dart';
import 'package:onestore_app/utils/failure.dart';

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
