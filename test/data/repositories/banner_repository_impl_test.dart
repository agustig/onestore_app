import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:onestore_app/data/repositories/banner_repository_impl.dart';
import 'package:onestore_app/domain/entities/banner.dart';
import 'package:onestore_app/domain/repositories/banner_repository.dart';
import 'package:onestore_app/utils/exceptions.dart';
import 'package:onestore_app/utils/failure.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../dummy_data/dummy_object.dart';
import '../../mock_helper.dart';

void main() {
  late final BannerRepository repository;
  late final MockBannerRemoteDataSource mockDataSource;

  setUpAll(() {
    mockDataSource = MockBannerRemoteDataSource();
    repository = BannerRepositoryImpl(mockDataSource);
  });

  group('getBanners():', () {
    const tBannerModels = [testBannerModel];

    mockCaller() => mockDataSource.getBanners();
    repositoryCaller() => repository.getBanners();

    test(
        'should return List of Banner entity when data source execute is successfully',
        () async {
      // Arrange
      when(() => mockCaller()).thenAnswer((_) async => tBannerModels);
      // Act
      final call = await repositoryCaller();
      // Assert
      verify(() => mockCaller());
      expect(call, isA<Right<Failure, List<Banner>>>());
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
