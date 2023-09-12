import 'package:dartz/dartz.dart';
import 'package:flutter_store_fic7/domain/entities/auth.dart';
import 'package:flutter_store_fic7/utils/failure.dart';

abstract class AuthRepository {
  Future<Either<Failure, Auth>> login({
    required String email,
    required String password,
  });

  Future<Either<Failure, Auth>> register({
    required String name,
    required String email,
    required String password,
    required String passwordConfirmation,
  });

  Future<Either<Failure, bool>> logout(String authToken);
  Future<Either<Failure, String?>> getAuthToken();
  Future<Either<Failure, bool>> removeAuthToken();
  Future<Either<Failure, bool>> saveAuthToken(String token);
}
