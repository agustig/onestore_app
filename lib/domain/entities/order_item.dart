import 'package:equatable/equatable.dart';

import 'package:onestore_app/domain/entities/product.dart';

class OrderItem extends Equatable {
  final Product product;
  final int quantity;

  const OrderItem({
    required this.product,
    required this.quantity,
  });

  @override
  List<Object> get props => [product, quantity];
}
