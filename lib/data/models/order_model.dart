import 'package:equatable/equatable.dart';

import 'package:flutter_store_fic7/data/models/order_item_model.dart';
import 'package:flutter_store_fic7/domain/entities/order.dart';

class OrderModel extends Equatable {
  final int id;
  final String number;
  final List<OrderItemModel> items;
  final String paymentUrl;
  final String deliveryAddress;
  final int totalPrice;
  final DateTime createdAt;
  final DateTime updatedAt;

  const OrderModel({
    required this.id,
    required this.number,
    required this.items,
    required this.paymentUrl,
    required this.deliveryAddress,
    required this.totalPrice,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'number': number,
      'items': items.map((item) => item.toMap()).toList(),
      'payment_url': paymentUrl,
      'delivery_address': deliveryAddress,
      'total_price': totalPrice,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String()
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      id: map['id'],
      number: map['number'],
      items:
          List.from(map['items'].map((item) => OrderItemModel.fromMap(item))),
      paymentUrl: map['payment_url'],
      deliveryAddress: map['delivery_address'],
      totalPrice: map['total_price'],
      createdAt: DateTime.parse(map['created_at']),
      updatedAt: DateTime.parse(map['updated_at']),
    );
  }

  Order toEntity() {
    return Order(
      id: id,
      number: number,
      items: items.map((item) => item.toEntity()).toList(),
      paymentUrl: paymentUrl,
      deliveryAddress: deliveryAddress,
      totalPrice: totalPrice,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  factory OrderModel.fromEntity(Order entity) {
    return OrderModel(
      id: entity.id,
      number: entity.number,
      items:
          entity.items.map((item) => OrderItemModel.fromEntity(item)).toList(),
      paymentUrl: entity.paymentUrl,
      deliveryAddress: entity.deliveryAddress,
      totalPrice: entity.totalPrice,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }

  @override
  List<Object?> get props {
    return [
      id,
      number,
      items,
      paymentUrl,
      deliveryAddress,
      totalPrice,
      createdAt,
      updatedAt,
    ];
  }
}
