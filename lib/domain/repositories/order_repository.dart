import 'package:dartz/dartz.dart' hide Order;
import 'package:onestore_app/domain/entities/order.dart';
import 'package:onestore_app/domain/entities/order_item.dart';
import 'package:onestore_app/utils/failure.dart';

abstract class OrderRepository {
  Future<Either<Failure, Order>> placeOrder({
    required List<OrderItem> items,
    required String deliveryAddress,
    required String authToken,
  });
}
