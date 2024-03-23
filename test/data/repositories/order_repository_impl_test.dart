import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:onestore_app/data/repositories/order_repository_impl.dart';
import 'package:onestore_app/domain/repositories/order_repository.dart';
import 'package:onestore_app/utils/exceptions.dart';
import 'package:onestore_app/utils/failure.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../dummy_data/dummy_object.dart';
import '../../mock_helper.dart';

void main() {
  late final OrderRepository orderRepository;
  late final MockOrderRemoteDataSource mockRemoteDataSource;

  setUpAll(() {
    mockRemoteDataSource = MockOrderRemoteDataSource();
    orderRepository = OrderRepositoryImpl(mockRemoteDataSource);
  });

  final tOrderModel = testOrderModel;
  final tOrder = testOrder;
  final tOrderItemsModel = [testOrderItemModel];
  final tOrderItems = [testOrderItem];
  const tAuthToken = 'sdaikwqeuihknjdaf3oiwrnasf';
  const tDeliveryAddress =
      'Jl Angkasa 1 Golden Boutique Hotel Lt Basement and Dasar, Dki Jakarta';

  group('placeOrder function:', () {
    orderRepositoryCaller() => orderRepository.placeOrder(
          items: tOrderItems,
          deliveryAddress: tDeliveryAddress,
          authToken: tAuthToken,
        );

    mockRemoteCaller() => mockRemoteDataSource.placeOrder(
          items: tOrderItemsModel,
          deliveryAddress: tDeliveryAddress,
          authToken: tAuthToken,
        );

    test('should return a Order Entity when data source execute is success',
        () async {
      // Arrange
      when(() => mockRemoteCaller()).thenAnswer((_) async => tOrderModel);
      // Act
      final call = await orderRepositoryCaller();
      // Assert
      verify(() => mockRemoteCaller());
      expect(call, equals(Right(tOrder)));
    });

    test(
      'should return ConnectionFailure when the device is not connected to internet',
      () async {
        // arrange
        when(() => mockRemoteCaller()).thenThrow(
            const SocketException('Failed to connect to the network'));
        // act
        final result = await orderRepositoryCaller();
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
      'should return UnauthorizeFailure when the access is unauthorize',
      () async {
        // arrange
        when(() => mockRemoteCaller()).thenThrow(UnauthorizeException());
        // act
        final result = await orderRepositoryCaller();
        // assert
        verify(() => mockRemoteCaller());
        expect(
          result,
          equals(
            const Left(UnauthorizeFailure(
              'Your auth token is incorrect or expired, please login again',
            )),
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
        final result = await orderRepositoryCaller();
        // assert
        verify(() => mockRemoteCaller());
        expect(result, equals(const Left(ServerFailure('Server Failure'))));
      },
    );
  });
}
