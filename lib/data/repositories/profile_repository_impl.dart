import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:onestore_app/data/data_sources/profile_remote_data_source.dart';
import 'package:onestore_app/domain/entities/user.dart';
import 'package:onestore_app/domain/repositories/profile_repository.dart';
import 'package:onestore_app/utils/exceptions.dart';
import 'package:onestore_app/utils/failure.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource dataSource;

  ProfileRepositoryImpl(this.dataSource);

  @override
  Future<Either<Failure, User>> getProfile({required String authToken}) async {
    try {
      final profileData = await dataSource.getProfile(authToken: authToken);
      return Right(profileData.toEntity());
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } on ServerException {
      return const Left(ServerFailure('Server Failure'));
    }
  }

  @override
  Future<Either<Failure, User>> updateProfile({required String authToken}) {
    // TODO: implement updateProfile
    throw UnimplementedError();
  }
}
