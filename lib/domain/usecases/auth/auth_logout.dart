import 'package:dartz/dartz.dart';
import 'package:onestore_app/domain/repositories/auth_repository.dart';
import 'package:onestore_app/utils/failure.dart';

class AuthLogout {
  final AuthRepository repository;

  AuthLogout(this.repository);

  Future<Either<Failure, bool>> execute(String authToken) {
    return repository.logout(authToken);
  }
}
