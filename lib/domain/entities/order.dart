import 'package:equatable/equatable.dart';

import 'package:onestore_app/domain/entities/order_item.dart';

class Order extends Equatable {
  final int id;
  final String number;
  final List<OrderItem> items;
  final String paymentUrl;
  final String deliveryAddress;
  final int totalPrice;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Order({
    required this.id,
    required this.number,
    required this.items,
    required this.paymentUrl,
    required this.deliveryAddress,
    required this.totalPrice,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props {
    return [
      id,
      number,
      items,
      paymentUrl,
      deliveryAddress,
      totalPrice,
    ];
  }
}
