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
  late final MockAuthLocalDataSource mockLocalDataSource;

  setUpAll(() {
    mockRemoteDataSource = MockAuthRemoteDataSource();
    mockLocalDataSource = MockAuthLocalDataSource();
    authRepository = AuthRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
    );
  });

  const tAuthModel = testAuthModel;
  const tAuth = testAuth;

  group('login function:', () {
    authRepositoryCaller() => authRepository.login(
          email: 'marlee.ledner@example.net',
          password: 'password',
        );

    mockRemoteCaller() => mockRemoteDataSource.login(
          email: 'marlee.ledner@example.net',
          password: 'password',
        );

    test('should return a Auth Entity when data source execute is success',
        () async {
      // Arrange
      when(() => mockRemoteCaller()).thenAnswer((_) async => tAuthModel);
      // Act
      final call = await authRepositoryCaller();
      // Assert
      verify(() => mockRemoteCaller());
      expect(call, equals(const Right(tAuth)));
    });

    test(
      'should return ConnectionFailure when the device is not connected to internet',
      () async {
        // arrange
        when(() => mockRemoteCaller()).thenThrow(
            const SocketException('Failed to connect to the network'));
        // act
        final result = await authRepositoryCaller();
        // assert
        verify(() => mockRemoteCaller());
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
        when(() => mockRemoteCaller()).thenThrow(ValidatorException({
          "email": ["The email field must be a valid email address."],
          "password": [
            "The password field must be at least 8 characters.",
            "The password field confirmation does not match."
          ]
        }));
        // act
        final result = await authRepositoryCaller();
        // assert
        verify(() => mockRemoteCaller());
        expect(
          result,
          equals(
            const Left(
              ValidatorFailure(
                {
                  "email": ["The email field must be a valid email address."],
                  "password": [
                    "The password field must be at least 8 characters.",
                    "The password field confirmation does not match."
                  ]
                },
              ),
            ),
          ),
        );
      },
    );

    test(
      'should return ServerFailure when the call to remote data source is unsuccessful',
      () async {
        // arrange
        when(() => mockRemoteCaller()).thenThrow(ServerException());
        // act
        final result = await authRepositoryCaller();
        // assert
        verify(() => mockRemoteCaller());
        expect(result, equals(const Left(ServerFailure('Server Failure'))));
      },
    );
  });

  group('register function:', () {
    authRepositoryCaller() => authRepository.register(
          name: 'Mr. Manuela Zboncak III',
          email: 'marlee.ledner@example.net',
          password: 'password',
          passwordConfirmation: 'password',
        );

    mockRemoteCaller() => mockRemoteDataSource.register(
          name: 'Mr. Manuela Zboncak III',
          email: 'marlee.ledner@example.net',
          password: 'password',
          passwordConfirmation: 'password',
        );

    test('should return a success message when data source execute is success',
        () async {
      // Arrange
      when(() => mockRemoteCaller()).thenAnswer((_) async => tAuthModel);
      // Act
      final call = await authRepositoryCaller();
      // Assert
      verify(() => mockRemoteCaller());
      expect(call, equals(const Right(testAuth)));
    });

    test(
      'should return ConnectionFailure when the device is not connected to internet',
      () async {
        // arrange
        when(() => mockRemoteCaller()).thenThrow(
            const SocketException('Failed to connect to the network'));
        // act
        final result = await authRepositoryCaller();
        // assert
        verify(() => mockRemoteCaller());
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
        when(() => mockRemoteCaller()).thenThrow(ValidatorException({
          "email": ["The email field must be a valid email address."],
          "password": [
            "The password field must be at least 8 characters.",
            "The password field confirmation does not match."
          ]
        }));
        // act
        final result = await authRepositoryCaller();
        // assert
        verify(() => mockRemoteCaller());
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
        when(() => mockRemoteCaller()).thenThrow(ServerException());
        // act
        final result = await authRepositoryCaller();
        // assert
        verify(() => mockRemoteCaller());
        expect(result, equals(const Left(ServerFailure('Server Failure'))));
      },
    );
  });

  group('logout function:', () {
    final tAuthToken = testAuthModel.token;
    authRepositoryCaller() => authRepository.logout(tAuthToken);
    mockRemoteCaller() => mockRemoteDataSource.logout(tAuthToken);

    test('should return a success message when data source execute is success',
        () async {
      // Arrange
      when(() => mockRemoteCaller()).thenAnswer((_) async => true);
      // Act
      final call = await authRepositoryCaller();
      // Assert
      verify(() => mockRemoteCaller());
      expect(call, equals(const Right(true)));
    });

    test(
      'should return ConnectionFailure when the device is not connected to internet',
      () async {
        // arrange
        when(() => mockRemoteCaller()).thenThrow(
            const SocketException('Failed to connect to the network'));
        // act
        final result = await authRepositoryCaller();
        // assert
        verify(() => mockRemoteCaller());
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
        when(() => mockRemoteCaller()).thenThrow(ServerException());
        // act
        final result = await authRepositoryCaller();
        // assert
        verify(() => mockRemoteCaller());
        expect(result, equals(const Left(ServerFailure('Server Failure'))));
      },
    );
  });

  group('getAuthToken function:', () {
    final tAuthToken = testAuthModel.token;
    authRepositoryCaller() => authRepository.getAuthToken();
    mockLocalCaller() => mockLocalDataSource.getAuthToken();

    test('should return a success message when data source execute is success',
        () async {
      // Arrange
      when(() => mockLocalCaller()).thenAnswer((_) async => tAuthToken);
      // Act
      final call = await authRepositoryCaller();
      // Assert
      verify(() => mockLocalCaller());
      expect(call, equals(Right(tAuthToken)));
    });

    test(
        'should return DatabaseFailure when the save authToken is unsuccessful',
        () async {
      // Arrange
      when(() => mockLocalCaller())
          .thenThrow(DatabaseException('Failed to save token'));
      // Act
      final call = await authRepositoryCaller();
      // Assert
      verify(() => mockLocalCaller());
      expect(call, equals(const Left(DatabaseFailure('Failed to save token'))));
    });
  });

  group('removeAuth function:', () {
    authRepositoryCaller() => authRepository.removeAuthToken();
    mockLocalCaller() => mockLocalDataSource.removeAuthToken();

    test('should return "true" when data source execute is success', () async {
      // Arrange
      when(() => mockLocalCaller()).thenAnswer((_) async => true);
      // Act
      final call = await authRepositoryCaller();
      // Assert
      verify(() => mockLocalCaller());
      expect(call, equals(const Right(true)));
    });

    test(
        'should return DatabaseFailure when the remove authToken is unsuccessful',
        () async {
      // Arrange
      when(() => mockLocalCaller())
          .thenThrow(DatabaseException('Failed to remove token'));
      // Act
      final call = await authRepositoryCaller();
      // Assert
      verify(() => mockLocalCaller());
      expect(
          call, equals(const Left(DatabaseFailure('Failed to remove token'))));
    });
  });

  group('saveAuthToken() function:', () {
    authRepositoryCaller() => authRepository.saveAuthToken(tAuthModel.token);
    mockLocalCaller() => mockLocalDataSource.saveAuthToken(tAuthModel.token);

    test('should return "true" when data source execute is success', () async {
      // Arrange
      when(() => mockLocalCaller()).thenAnswer((_) async => true);
      // Act
      final call = await authRepositoryCaller();
      // Assert
      verify(() => mockLocalCaller());
      expect(call, equals(const Right(true)));
    });

    test('should return DatabaseFailure when the get authToken is unsuccessful',
        () async {
      // Arrange
      when(() => mockLocalCaller())
          .thenThrow(DatabaseException('Failed to get token'));
      // Act
      final call = await authRepositoryCaller();
      // Assert
      verify(() => mockLocalCaller());
      expect(call, equals(const Left(DatabaseFailure('Failed to get token'))));
    });
  });
}
