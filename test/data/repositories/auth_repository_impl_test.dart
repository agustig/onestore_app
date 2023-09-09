import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_store_fic7/data/repositories/auth_repository_impl.dart';
import 'package:flutter_store_fic7/domain/repositories/auth_repository.dart';
import 'package:flutter_store_fic7/utils/exceptions.dart';
import 'package:flutter_store_fic7/utils/failure.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../dummy_data/dummy_object.dart';
import '../../mock_helper.dart';

void main() {
  late final AuthRepository authRepository;
  late final MockAuthRemoteDataSource mockRemoteDataSource;

  setUpAll(() {
    mockRemoteDataSource = MockAuthRemoteDataSource();
    authRepository = AuthRepositoryImpl(remoteDataSource: mockRemoteDataSource);
  });

  const tAuthModel = testAuthModel;
  const tAuth = testAuth;

  group('Login function:', () {
    authRepositoryCaller() => authRepository.login(
          email: 'marlee.ledner@example.net',
          password: 'password',
        );

    mockCaller() => mockRemoteDataSource.login(
          email: 'marlee.ledner@example.net',
          password: 'password',
        );

    test(
        'should return a valid Auth entity when data source execute is success',
        () async {
      // Arrange
      when(() => mockCaller()).thenAnswer((_) async => tAuthModel);
      // Act
      final call = await authRepositoryCaller();
      // Assert
      verify(() => mockCaller());
      expect(call, equals(const Right(tAuth)));
    });

    test(
      'should return ConnectionFailure when the device is not connected to internet',
      () async {
        // arrange
        when(() => mockCaller()).thenThrow(
            const SocketException('Failed to connect to the network'));
        // act
        final result = await authRepositoryCaller();
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
      'should return ValidatorFailure when request is wrong',
      () async {
        // arrange
        when(() => mockCaller()).thenThrow(ValidatorException({
          "email": ["The email field must be a valid email address."],
          "password": [
            "The password field must be at least 8 characters.",
            "The password field confirmation does not match."
          ]
        }));
        // act
        final result = await authRepositoryCaller();
        // assert
        verify(() => mockCaller());
        expect(
          result,
          equals(
            const Left(ValidatorFailure({
              "email": ["The email field must be a valid email address."],
              "password": [
                "The password field must be at least 8 characters.",
                "The password field confirmation does not match."
              ]
            })),
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
        final result = await authRepositoryCaller();
        // assert
        verify(() => mockCaller());
        expect(result, equals(const Left(ServerFailure('Server Failure'))));
      },
    );
  });

  group('Register function:', () {
    authRepositoryCaller() => authRepository.register(
          name: 'Mr. Manuela Zboncak III',
          email: 'marlee.ledner@example.net',
          password: 'password',
          passwordConfirmation: 'password',
        );

    mockCaller() => mockRemoteDataSource.register(
          name: 'Mr. Manuela Zboncak III',
          email: 'marlee.ledner@example.net',
          password: 'password',
          passwordConfirmation: 'password',
        );

    test(
        'should return a valid Auth entity when data source execute is success',
        () async {
      // Arrange
      when(() => mockCaller()).thenAnswer((_) async => tAuthModel);
      // Act
      final call = await authRepositoryCaller();
      // Assert
      verify(() => mockCaller());
      expect(call, equals(const Right(tAuth)));
    });

    test(
      'should return ConnectionFailure when the device is not connected to internet',
      () async {
        // arrange
        when(() => mockCaller()).thenThrow(
            const SocketException('Failed to connect to the network'));
        // act
        final result = await authRepositoryCaller();
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
      'should return ValidatorFailure when request is wrong',
      () async {
        // arrange
        when(() => mockCaller()).thenThrow(ValidatorException({
          "email": ["The email field must be a valid email address."],
          "password": [
            "The password field must be at least 8 characters.",
            "The password field confirmation does not match."
          ]
        }));
        // act
        final result = await authRepositoryCaller();
        // assert
        verify(() => mockCaller());
        expect(
          result,
          equals(
            const Left(ValidatorFailure({
              "email": ["The email field must be a valid email address."],
              "password": [
                "The password field must be at least 8 characters.",
                "The password field confirmation does not match."
              ]
            })),
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
        final result = await authRepositoryCaller();
        // assert
        verify(() => mockCaller());
        expect(result, equals(const Left(ServerFailure('Server Failure'))));
      },
    );
  });
}
