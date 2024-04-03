import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:onestore_app/data/repositories/profile_repository_impl.dart';
import 'package:onestore_app/domain/repositories/profile_repository.dart';
import 'package:onestore_app/utils/exceptions.dart';
import 'package:onestore_app/utils/failure.dart';

import '../../dummy_data/dummy_object.dart';
import '../../mock_helper.dart';

void main() {
  late final ProfileRepository repository;
  late final MockProfileRemoteDataSource mockRemoteDataSource;

  setUpAll(() {
    mockRemoteDataSource = MockProfileRemoteDataSource();
    repository = ProfileRepositoryImpl(mockRemoteDataSource);
  });

  final tAuthToken = testAuthModel.token;

  group('getProfile function:', () {
    const tUserModel = testUserModel;
    const tUser = testUser;

    mockCaller() => mockRemoteDataSource.getProfile(authToken: tAuthToken);
    repositoryCaller() => repository.getProfile(authToken: tAuthToken);

    test('should return a User Entity when data source execute is success',
        () async {
      // Arrange
      when(() => mockCaller()).thenAnswer((_) async => tUserModel);
      // Act
      final call = await repositoryCaller();
      // Assert
      verify(() => mockCaller());
      expect(call, equals(const Right(tUser)));
    });

    test(
      'should return ConnectionFailure when the device is not connected to internet',
      () async {
        // arrange
        when(() => mockCaller()).thenThrow(
            const SocketException('Failed to connect to the network'));
        // act
        final result = await repositoryCaller();
        // assert
        verify(() => mockCaller());
        expect(
          result,
          equals(
            const Left(ConnectionFailure('Failed to connect to the network')),
          ),
        );
      },
    );

    test(
      'should return ServerFailure when the call to remote data source is unsuccessful',
      () async {
        // arrange
        when(() => mockCaller()).thenThrow(ServerException());
        // act
        final result = await repositoryCaller();
        // assert
        verify(() => mockCaller());
        expect(result, equals(const Left(ServerFailure('Server Failure'))));
      },
    );
  });
}
