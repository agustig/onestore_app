import 'dart:io';

import 'package:dartz/dartz.dart' hide Order;
import 'package:flutter_store_fic7/data/data_sources/order_remote_data_source.dart';
import 'package:flutter_store_fic7/data/models/order_item_model.dart';
import 'package:flutter_store_fic7/domain/entities/order.dart';
import 'package:flutter_store_fic7/domain/entities/order_item.dart';
import 'package:flutter_store_fic7/domain/repositories/order_repository.dart';
import 'package:flutter_store_fic7/utils/exceptions.dart';
import 'package:flutter_store_fic7/utils/failure.dart';

class OrderRepositoryImpl implements OrderRepository {
  final OrderRemoteDataSource dataSource;

  OrderRepositoryImpl(this.dataSource);

  @override
  Future<Either<Failure, Order>> placeOrder({
    required List<OrderItem> items,
    required String deliveryAddress,
    required String authToken,
  }) async {
    final itemsModel =
        items.map((item) => OrderItemModel.fromEntity(item)).toList();
    try {
      final orderData = await dataSource.placeOrder(
        items: itemsModel,
        deliveryAddress: deliveryAddress,
        authToken: authToken,
      );
      return Right(orderData.toEntity());
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } on UnauthorizeException {
      return const Left(
        UnauthorizeFailure(
          'Your auth token is incorrect or expired, please login again',
        ),
      );
    } on ServerException {
      return const Left(ServerFailure('Server Failure'));
    }
  }
}
