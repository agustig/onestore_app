import 'package:dartz/dartz.dart' hide Order;
import 'package:onestore_app/domain/entities/order.dart';
import 'package:onestore_app/domain/entities/order_item.dart';
import 'package:onestore_app/domain/repositories/order_repository.dart';
import 'package:onestore_app/utils/failure.dart';

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
