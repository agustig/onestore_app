part of 'order_bloc.dart';

@freezed
class OrderEvent with _$OrderEvent {
  const factory OrderEvent.addProduct(Product product) = _AddProduct;
  const factory OrderEvent.removeProduct(Product product) = _RemoveProduct;
  const factory OrderEvent.resetItem() = _ResetItem;
  const factory OrderEvent.addItemToCart() = _AddItemToCart;
  const factory OrderEvent.buySingle({
    required String deliveryAddress,
    required String authToken,
  }) = _BuySingle;
  const factory OrderEvent.checkoutCart({
    required String deliveryAddress,
    required String authToken,
  }) = _CheckoutCart;
  const factory OrderEvent.addCheckoutStatus(bool isPlaced) =
      _AddCheckoutStatus;
  const factory OrderEvent.removeFromCart(OrderItem item) = _RemoveFromCart;
  const factory OrderEvent.incrementInCart(OrderItem item) = _IncrementInCart;
  const factory OrderEvent.decrementInCart(OrderItem product) =
      _DecrementInCart;
}
