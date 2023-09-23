import 'package:equatable/equatable.dart';

import 'package:flutter_store_fic7/domain/entities/product.dart';

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
