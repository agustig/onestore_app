import 'package:equatable/equatable.dart';
import 'package:flutter_store_fic7/data/models/product_model.dart';
import 'package:flutter_store_fic7/domain/entities/order_item.dart';

class OrderItemModel extends Equatable {
  final ProductModel product;
  final int quantity;

  const OrderItemModel({
    required this.product,
    required this.quantity,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'product': product.toMap(),
      'quantity': quantity,
    };
  }

  Map<String, dynamic> toCheckoutItem() {
    return <String, dynamic>{
      'id': product.id,
      'quantity': quantity,
    };
  }

  factory OrderItemModel.fromMap(Map<String, dynamic> map) {
    return OrderItemModel(
      product: ProductModel.fromMap(map['product']),
      quantity: map['quantity'],
    );
  }

  OrderItem toEntity() {
    return OrderItem(
      product: product.toEntity(),
      quantity: quantity,
    );
  }

  factory OrderItemModel.fromEntity(OrderItem entity) {
    return OrderItemModel(
      product: ProductModel.fromEntity(entity.product),
      quantity: entity.quantity,
    );
  }

  @override
  List<Object?> get props => [product, quantity];
}
