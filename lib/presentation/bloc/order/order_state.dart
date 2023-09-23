part of 'order_bloc.dart';

enum OrderProcessingStatus { empty, loading, success, error }

@freezed
class OrderState with _$OrderState {
  const factory OrderState({
    OrderItem? currentItem,
    required List<OrderItem> cart,
    Order? processing,
    required List<Order> ordersPlaced,
    required List<Order> ordersFailed,
    String? errorMessage,
    required OrderProcessingStatus status,
  }) = _OrderState;

  factory OrderState.empty() => const OrderState(
        cart: [],
        ordersPlaced: [],
        ordersFailed: [],
        status: OrderProcessingStatus.empty,
      );

  const OrderState._();

  factory OrderState.fromMap(Map<String, dynamic> map) {
    return OrderState(
      cart: List.from(map['cart'])
          .map((item) => OrderItemModel.fromMap(item).toEntity())
          .toList(),
      processing: (map['processing'] != null)
          ? OrderModel.fromMap(map['processing']).toEntity()
          : null,
      ordersPlaced: List.from(map['orders_placed'])
          .map((item) => OrderModel.fromMap(item).toEntity())
          .toList(),
      ordersFailed: List.from(map['orders_filed'])
          .map((item) => OrderModel.fromMap(item).toEntity())
          .toList(),
      status: OrderProcessingStatus.empty,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "cart":
          cart.map((item) => OrderItemModel.fromEntity(item).toMap()).toList(),
      "processing": (processing != null)
          ? OrderModel.fromEntity(processing!).toMap()
          : null,
      "orders_placed": ordersPlaced
          .map((item) => OrderModel.fromEntity(item).toMap())
          .toList(),
      "orders_failed": ordersFailed
          .map((item) => OrderModel.fromEntity(item).toMap())
          .toList(),
    };
  }
}
