import 'package:dartz/dartz.dart' hide Order;
import 'package:flutter_store_fic7/domain/entities/order.dart';
import 'package:flutter_store_fic7/domain/entities/order_item.dart';
import 'package:flutter_store_fic7/domain/repositories/order_repository.dart';
import 'package:flutter_store_fic7/utils/failure.dart';

class PlaceOrder {
  final OrderRepository repository;

  PlaceOrder(this.repository);

  Future<Either<Failure, Order>> execute({
    required List<OrderItem> items,
    required String deliveryAddress,
    required String authToken,
  }) {
    return repository.placeOrder(
      items: items,
      deliveryAddress: deliveryAddress,
      authToken: authToken,
    );
  }
}
