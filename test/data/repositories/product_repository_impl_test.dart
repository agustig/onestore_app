import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:onestore_app/data/repositories/product_repository_impl.dart';
import 'package:onestore_app/domain/repositories/product_repository.dart';
import 'package:onestore_app/utils/exceptions.dart';
import 'package:onestore_app/utils/failure.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../dummy_data/dummy_object.dart';
import '../../mock_helper.dart';

void main() {
  late final MockProductRemoteDataSource mockDataSource;
  late final ProductRepository repository;

  setUpAll(() {
    mockDataSource = MockProductRemoteDataSource();
    repository = ProductRepositoryImpl(mockDataSource);
  });

  group('getProduct function:', () {
    final tProductModelDetail = testProductModelDetail;
    final tProductDetail = testProductDetail;

    mockCaller() => mockDataSource.getProduct(id: 1);
    repositoryCaller() => repository.getProduct(id: 1);

    test('should return a Product Entity when data source execute is success',
        () async {
      // Arrange
      when(() => mockCaller()).thenAnswer((_) async => tProductModelDetail);
      // Act
      final call = await repositoryCaller();
      // Assert
      verify(() => mockCaller());
      expect(call, equals(Right(tProductDetail)));
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

  group('getProducts function:', () {
    const tProductCollectionModel = testProductCollectionModel;
    const tProductCollection = testProductCollection;

    mockCaller() => mockDataSource.getProducts();
    repositoryCaller() => repository.getProducts();

    test(
        'should return a Product collection when data source execute is success',
        () async {
      // Arrange
      when(() => mockCaller()).thenAnswer((_) async => tProductCollectionModel);
      // Act
      final call = await repositoryCaller();
      // Assert
      verify(() => mockCaller());
      expect(call, equals(const Right(tProductCollection)));
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

  group('getProductsByCategory function:', () {
    const tProductCollectionModel = testProductCollectionModel;
    const tProductCollection = testProductCollection;

    mockCaller() => mockDataSource.getProductsByCategory(1);
    repositoryCaller() => repository.getProductsByCategory(1);

    test(
        'should return a Product collection when data source execute is success',
        () async {
      // Arrange
      when(() => mockCaller()).thenAnswer((_) async => tProductCollectionModel);
      // Act
      final call = await repositoryCaller();
      // Assert
      verify(() => mockCaller());
      expect(call, equals(const Right(tProductCollection)));
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
