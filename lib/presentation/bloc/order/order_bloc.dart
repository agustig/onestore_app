import 'package:flutter_store_fic7/data/models/order_item_model.dart';
import 'package:flutter_store_fic7/data/models/order_model.dart';
import 'package:flutter_store_fic7/domain/entities/order.dart';
import 'package:flutter_store_fic7/domain/entities/order_item.dart';
import 'package:flutter_store_fic7/domain/entities/product.dart';
import 'package:flutter_store_fic7/domain/usecases/order/place_order.dart';
import 'package:flutter_store_fic7/utils/failure.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'order_event.dart';
part 'order_state.dart';
part 'order_bloc.freezed.dart';

class OrderBloc extends HydratedBloc<OrderEvent, OrderState> {
  final PlaceOrder _placeOrder;
  OrderBloc({
    required PlaceOrder placeOrder,
  })  : _placeOrder = placeOrder,
        super(OrderState.empty()) {
    on<_AddProduct>(_onAddProduct);
    on<_RemoveProduct>(_onRemoveProduct);
    on<_ResetItem>(_onResetItem);
    on<_AddItemToCart>(_onAddItemToCart);
    on<_BuySingle>(_onBuySingle);
    on<_CheckoutCart>(_onCheckoutCart);
    on<_AddCheckoutStatus>(_onAddCheckoutStatus);
    on<_RemoveFromCart>(_onRemoveFromCart);
    on<_IncrementInCart>(_onIncrementInCart);
    on<_DecrementInCart>(_onDecrementInCart);
  }

  _onAddProduct(_AddProduct event, Emitter<OrderState> emit) {
    late final OrderItem currentItem;
    if (state.currentItem == null ||
        state.currentItem!.product != event.product) {
      currentItem = OrderItem(product: event.product, quantity: 1);
    } else {
      currentItem = OrderItem(
        product: state.currentItem!.product,
        quantity: state.currentItem!.quantity + 1,
      );
    }
    emit(state.copyWith(currentItem: currentItem));
  }

  _onRemoveProduct(_RemoveProduct event, Emitter<OrderState> emit) {
    final currentItem = OrderItem(
      product: state.currentItem!.product,
      quantity: state.currentItem!.quantity - 1,
    );

    emit(state.copyWith(currentItem: currentItem));
  }

  _onResetItem(_ResetItem event, Emitter<OrderState> emit) {
    emit(state.copyWith(currentItem: null));
  }

  _onAddItemToCart(_AddItemToCart event, Emitter<OrderState> emit) {
    var currentCart = List<OrderItem>.from(state.cart);
    final productsInCart = currentCart.map((item) => item.product).toList();

    if (productsInCart.contains(state.currentItem!.product)) {
      final oldItem = currentCart
          .where((item) => item.product == state.currentItem!.product)
          .toList()[0];
      final updatedItem = OrderItem(
        product: oldItem.product,
        quantity: oldItem.quantity + state.currentItem!.quantity,
      );
      final itemIndex = currentCart.indexOf(oldItem);
      currentCart.remove(oldItem);
      currentCart.insert(itemIndex, updatedItem);
    } else {
      currentCart.add(state.currentItem!);
    }

    emit(state.copyWith(currentItem: null, cart: currentCart));
  }

  _onBuySingle(_BuySingle event, Emitter<OrderState> emit) async {
    emit(state.copyWith(status: OrderProcessingStatus.loading));
    try {
      final currentItems = [state.currentItem!];
      final result = await _placeOrder.execute(
        items: currentItems,
        deliveryAddress: event.deliveryAddress,
        authToken: event.authToken,
      );
      result.fold(
        (failure) => throw failure,
        (orderData) => emit(state.copyWith(
          currentItem: null,
          status: OrderProcessingStatus.success,
          processing: orderData,
        )),
      );
    } on Failure catch (failure) {
      emit(state.copyWith(
        status: OrderProcessingStatus.error,
        errorMessage: failure.message,
      ));
    }
  }

  _onCheckoutCart(_CheckoutCart event, Emitter<OrderState> emit) async {
    emit(state.copyWith(status: OrderProcessingStatus.loading));
    try {
      final currentItems = state.cart;
      final result = await _placeOrder.execute(
        items: currentItems,
        deliveryAddress: event.deliveryAddress,
        authToken: event.authToken,
      );
      result.fold(
        (failure) => throw failure,
        (orderData) => emit(state.copyWith(
          cart: [],
          status: OrderProcessingStatus.success,
          processing: orderData,
        )),
      );
    } on Failure catch (failure) {
      emit(state.copyWith(
        status: OrderProcessingStatus.error,
        errorMessage: failure.message,
      ));
    }
  }

  _onAddCheckoutStatus(_AddCheckoutStatus event, Emitter<OrderState> emit) {
    final currentProcessingOrder = event.order;
    if (event.isPlaced) {
      emit(
        state.copyWith(
          processing: null,
          status: OrderProcessingStatus.empty,
          ordersPlaced: List.from(state.ordersPlaced)
            ..insert(0, currentProcessingOrder),
        ),
      );
    } else {
      emit(
        state.copyWith(
          processing: null,
          status: OrderProcessingStatus.empty,
          ordersFailed: List.from(state.ordersFailed)
            ..insert(0, currentProcessingOrder),
        ),
      );
    }
  }

  _onRemoveFromCart(_RemoveFromCart event, Emitter<OrderState> emit) {
    final newCart = List<OrderItem>.from(state.cart)..remove(event.item);
    emit(state.copyWith(cart: newCart));
  }

  _onIncrementInCart(_IncrementInCart event, Emitter<OrderState> emit) {
    // TODO: Add Logic onIncrementInCart
  }

  _onDecrementInCart(_DecrementInCart event, Emitter<OrderState> emit) {
    // TODO: Add Logic onDecrementInCart
  }

  @override
  OrderState? fromJson(Map<String, dynamic> json) {
    return OrderState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(OrderState state) {
    return state.toMap();
  }
}
