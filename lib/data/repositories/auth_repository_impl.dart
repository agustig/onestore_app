import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:onestore_app/data/data_sources/auth_local_data_source.dart';
import 'package:onestore_app/data/data_sources/auth_remote_data_source.dart';
import 'package:onestore_app/domain/entities/auth.dart';
import 'package:onestore_app/domain/repositories/auth_repository.dart';
import 'package:onestore_app/utils/exceptions.dart';
import 'package:onestore_app/utils/failure.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, Auth>> login({
    required String email,
    required String password,
  }) async {
    try {
      final authData = await remoteDataSource.login(
        email: email,
        password: password,
      );

      return Right(authData.toEntity());
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } on ValidatorException catch (e) {
      return Left(ValidatorFailure(e.messages));
    } on ServerException {
      return const Left(ServerFailure('Server Failure'));
    }
  }

  @override
  Future<Either<Failure, Auth>> register({
    required String name,
    required String email,
    required String password,
    required String passwordConfirmation,
  }) async {
    try {
      final authData = await remoteDataSource.register(
        name: name,
        email: email,
        password: password,
        passwordConfirmation: passwordConfirmation,
      );

      return Right(authData.toEntity());
    } on ValidatorException catch (e) {
      return Left(ValidatorFailure(e.messages));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } on ServerException {
      return const Left(ServerFailure('Server Failure'));
    }
  }

  @override
  Future<Either<Failure, bool>> logout(String authToken) async {
    try {
      final result = await remoteDataSource.logout(authToken);
      return Right(result);
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } on ServerException {
      return const Left(ServerFailure('Server Failure'));
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, String?>> getAuthToken() async {
    try {
      final result = await localDataSource.getAuthToken();
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, bool>> removeAuthToken() async {
    try {
      final result = await localDataSource.removeAuthToken();
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, bool>> saveAuthToken(String authToken) async {
    try {
      final result = await localDataSource.saveAuthToken(authToken);
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }
}
