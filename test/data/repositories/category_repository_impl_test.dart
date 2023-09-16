import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_store_fic7/data/repositories/category_repository_impl.dart';
import 'package:flutter_store_fic7/domain/repositories/category_repository.dart';
import 'package:flutter_store_fic7/utils/exceptions.dart';
import 'package:flutter_store_fic7/utils/failure.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../dummy_data/dummy_object.dart';
import '../../mock_helper.dart';

void main() {
  late final MockCategoryRemoteDataSource mockDataSource;
  late final CategoryRepository repository;

  setUpAll(() {
    mockDataSource = MockCategoryRemoteDataSource();
    repository = CategoryRepositoryImpl(mockDataSource);
  });

  group('getCategory function:', () {
    final tCategoryModelDetail = testCategoryModelDetail;
    final tCategoryDetail = testCategoryDetail;

    mockCaller() => mockDataSource.getCategory(id: 1);
    repositoryCaller() => repository.getCategory(id: 1);

    test('should return a Category Entity when data source execute is success',
        () async {
      // Arrange
      when(() => mockCaller()).thenAnswer((_) async => tCategoryModelDetail);
      // Act
      final call = await repositoryCaller();
      // Assert
      verify(() => mockCaller());
      expect(call, equals(Right(tCategoryDetail)));
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

  group('getCategories function:', () {
    const tCategoryCollectionModel = testCategoryCollectionModel;
    const tCategoryCollection = testCategoryCollection;

    mockCaller() => mockDataSource.getCategories();
    repositoryCaller() => repository.getCategories();

    test(
        'should return a Category collection when data source execute is success',
        () async {
      // Arrange
      when(() => mockCaller())
          .thenAnswer((_) async => tCategoryCollectionModel);
      // Act
      final call = await repositoryCaller();
      // Assert
      verify(() => mockCaller());
      expect(call, equals(const Right(tCategoryCollection)));
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
