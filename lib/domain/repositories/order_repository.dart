import 'package:dartz/dartz.dart' hide Order;
import 'package:flutter_store_fic7/domain/entities/order.dart';
import 'package:flutter_store_fic7/domain/entities/order_item.dart';
import 'package:flutter_store_fic7/utils/failure.dart';

abstract class OrderRepository {
  Future<Either<Failure, Order>> placeOrder({
    required List<OrderItem> items,
    required String deliveryAddress,
    required String authToken,
  });
}
