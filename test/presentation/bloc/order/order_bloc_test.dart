import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_store_fic7/presentation/bloc/order/order_bloc.dart';
import 'package:flutter_store_fic7/utils/failure.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:mocktail/mocktail.dart';

import '../../../dummy_data/dummy_object.dart';
import '../../../mock_helper.dart';

void main() {
  late OrderBloc orderBloc;
  late MockPlaceOrder mockPlaceOrder;

  late Storage hydratedStorage;

  TestWidgetsFlutterBinding.ensureInitialized();
  hydratedStorage = MockStorage();
  when(() => hydratedStorage.write(any(), any<dynamic>()))
      .thenAnswer((_) async {});
  HydratedBloc.storage = hydratedStorage;

  setUp(() {
    mockPlaceOrder = MockPlaceOrder();

    orderBloc = OrderBloc(placeOrder: mockPlaceOrder);
  });

  final tOrder = testOrder;
  final tOrder2 = testOrder2;
  final tOrderItem = testOrderItem;
  final tOrderItem2 = testOrderItem2;
  final tOrderItems = [tOrderItem];
  final tOrderItems2 = [tOrderItem2];
  const tAuthToken = 'sdaikwqeuihknjdaf3oiwrnasf';
  const tDeliveryAddress =
      'Jl Angkasa 1 Golden Boutique Hotel Lt Basement and Dasar, Dki Jakarta';
  final tProduct = testProductDetail;

  test('initial setup should be initial state', () {
    expect(orderBloc.state, OrderState.empty());
  });

  group('Cart Checkout', () {
    final addProductCaller = OrderEvent.addProduct(tProduct);
    final removeProductCaller = OrderEvent.removeProduct(tProduct);
    const addItemToCartCaller = OrderEvent.addItemToCart();
    const checkoutCartCaller = OrderEvent.checkoutCart(
      deliveryAddress: tDeliveryAddress,
      authToken: tAuthToken,
    );
    final state = OrderState.empty();

    mockPlaceOrderUsecaseCaller() => mockPlaceOrder.execute(
          items: tOrderItems2,
          deliveryAddress: tDeliveryAddress,
          authToken: tAuthToken,
        );

    blocTest<OrderBloc, OrderState>(
      'Cart checkout with payment success',
      build: () {
        when(() => mockPlaceOrderUsecaseCaller())
            .thenAnswer((_) async => Right(tOrder2));
        return orderBloc;
      },
      act: (bloc) => [
        bloc.add(addProductCaller),
        bloc.add(addProductCaller),
        bloc.add(removeProductCaller),
        bloc.add(const OrderEvent.resetItem()),
        bloc.add(addProductCaller),
        bloc.add(addItemToCartCaller),
        bloc.add(addProductCaller),
        bloc.add(addItemToCartCaller),
        bloc.add(checkoutCartCaller),
        bloc.add(const OrderEvent.addCheckoutStatus(true))
      ],
      expect: () => [
        state.copyWith(currentItem: tOrderItem),
        state.copyWith(currentItem: tOrderItem2),
        state.copyWith(currentItem: tOrderItem),
        state,
        state.copyWith(currentItem: tOrderItem),
        state.copyWith(cart: tOrderItems),
        state.copyWith(currentItem: tOrderItem, cart: tOrderItems),
        state.copyWith(cart: tOrderItems2),
        // onCheckout
        state.copyWith(
          cart: tOrderItems2,
          status: OrderProcessingStatus.loading,
        ),
        state.copyWith(
          processing: tOrder2,
          status: OrderProcessingStatus.success,
        ),
        // onCheckoutSuccess
        state.copyWith(
          status: OrderProcessingStatus.empty,
          ordersPlaced: [tOrder2],
        ),
      ],
      verify: (bloc) => [mockPlaceOrderUsecaseCaller()],
    );

    blocTest<OrderBloc, OrderState>(
      'Cart checkout with payment failed',
      build: () {
        when(() => mockPlaceOrderUsecaseCaller())
            .thenAnswer((_) async => Right(tOrder2));
        return orderBloc;
      },
      act: (bloc) => [
        bloc.add(addProductCaller),
        bloc.add(addProductCaller),
        bloc.add(removeProductCaller),
        bloc.add(const OrderEvent.resetItem()),
        bloc.add(addProductCaller),
        bloc.add(addItemToCartCaller),
        bloc.add(addProductCaller),
        bloc.add(addItemToCartCaller),
        bloc.add(checkoutCartCaller),
        bloc.add(const OrderEvent.addCheckoutStatus(false))
      ],
      expect: () => [
        state.copyWith(currentItem: tOrderItem),
        state.copyWith(currentItem: tOrderItem2),
        state.copyWith(currentItem: tOrderItem),
        state,
        state.copyWith(currentItem: tOrderItem),
        state.copyWith(cart: tOrderItems),
        state.copyWith(currentItem: tOrderItem, cart: tOrderItems),
        state.copyWith(cart: tOrderItems2),
        // onCheckout
        state.copyWith(
          cart: tOrderItems2,
          status: OrderProcessingStatus.loading,
        ),
        state.copyWith(
          processing: tOrder2,
          status: OrderProcessingStatus.success,
        ),
        // onCheckoutFailed
        state.copyWith(
          status: OrderProcessingStatus.empty,
          ordersFailed: [tOrder2],
        ),
      ],
      verify: (bloc) => [mockPlaceOrderUsecaseCaller()],
    );

    blocTest<OrderBloc, OrderState>(
      'Cart checkout with placing failed',
      build: () {
        when(() => mockPlaceOrderUsecaseCaller()).thenAnswer(
            (_) async => const Left(ServerFailure('Server failure')));
        return orderBloc;
      },
      act: (bloc) => [
        bloc.add(addProductCaller),
        bloc.add(addProductCaller),
        bloc.add(removeProductCaller),
        bloc.add(const OrderEvent.resetItem()),
        bloc.add(addProductCaller),
        bloc.add(addItemToCartCaller),
        bloc.add(addProductCaller),
        bloc.add(addItemToCartCaller),
        bloc.add(checkoutCartCaller),
      ],
      expect: () => [
        state.copyWith(currentItem: tOrderItem),
        state.copyWith(currentItem: tOrderItem2),
        state.copyWith(currentItem: tOrderItem),
        state,
        state.copyWith(currentItem: tOrderItem),
        state.copyWith(cart: tOrderItems),
        state.copyWith(currentItem: tOrderItem, cart: tOrderItems),
        state.copyWith(cart: tOrderItems2),
        // onCheckout
        state.copyWith(
          cart: tOrderItems2,
          status: OrderProcessingStatus.loading,
        ),
        state.copyWith(
          cart: tOrderItems2,
          status: OrderProcessingStatus.error,
          errorMessage: 'Server failure',
        ),
      ],
      verify: (bloc) => [mockPlaceOrderUsecaseCaller()],
    );
  });

  group('Single item Checkout', () {
    final addProductCaller = OrderEvent.addProduct(tProduct);
    const addItemToCartCaller = OrderEvent.addItemToCart();
    final removeFromCartCaller = OrderEvent.removeFromCart(tOrderItem);
    const buySingleCaller = OrderEvent.buySingle(
      deliveryAddress: tDeliveryAddress,
      authToken: tAuthToken,
    );
    final state = OrderState.empty();

    mockPlaceOrderUsecaseCaller() => mockPlaceOrder.execute(
          items: tOrderItems,
          deliveryAddress: tDeliveryAddress,
          authToken: tAuthToken,
        );

    blocTest<OrderBloc, OrderState>(
      'Single checkout with payment success',
      build: () {
        when(() => mockPlaceOrderUsecaseCaller())
            .thenAnswer((_) async => Right(tOrder));
        return orderBloc;
      },
      act: (bloc) => [
        bloc.add(addProductCaller),
        bloc.add(addItemToCartCaller),
        bloc.add(removeFromCartCaller),
        bloc.add(addProductCaller),
        bloc.add(buySingleCaller),
        bloc.add(const OrderEvent.addCheckoutStatus(true))
      ],
      expect: () => [
        state.copyWith(currentItem: tOrderItem),
        state.copyWith(cart: tOrderItems),
        state,
        state.copyWith(currentItem: tOrderItem),
        // onBuySingle
        state.copyWith(
          currentItem: tOrderItem,
          status: OrderProcessingStatus.loading,
        ),
        state.copyWith(
          processing: tOrder,
          status: OrderProcessingStatus.success,
        ),
        // onCheckoutSuccess
        state.copyWith(
          status: OrderProcessingStatus.empty,
          ordersPlaced: [tOrder],
        ),
      ],
      verify: (bloc) => [mockPlaceOrderUsecaseCaller()],
    );

    blocTest<OrderBloc, OrderState>(
      'Single checkout with payment failed',
      build: () {
        when(() => mockPlaceOrderUsecaseCaller())
            .thenAnswer((_) async => Right(tOrder));
        return orderBloc;
      },
      act: (bloc) => [
        bloc.add(addProductCaller),
        bloc.add(addItemToCartCaller),
        bloc.add(removeFromCartCaller),
        bloc.add(addProductCaller),
        bloc.add(buySingleCaller),
        bloc.add(const OrderEvent.addCheckoutStatus(false))
      ],
      expect: () => [
        state.copyWith(currentItem: tOrderItem),
        state.copyWith(cart: tOrderItems),
        state,
        state.copyWith(currentItem: tOrderItem),
        // onBuySingle
        state.copyWith(
          currentItem: tOrderItem,
          status: OrderProcessingStatus.loading,
        ),
        state.copyWith(
          processing: tOrder,
          status: OrderProcessingStatus.success,
        ),
        // onCheckoutSuccess
        state.copyWith(
          status: OrderProcessingStatus.empty,
          ordersFailed: [tOrder],
        ),
      ],
      verify: (bloc) => [mockPlaceOrderUsecaseCaller()],
    );

    blocTest<OrderBloc, OrderState>(
      'Single checkout with placing failed',
      build: () {
        when(() => mockPlaceOrderUsecaseCaller()).thenAnswer(
            (_) async => const Left(ServerFailure('Server failure')));
        return orderBloc;
      },
      act: (bloc) => [
        bloc.add(addProductCaller),
        bloc.add(addItemToCartCaller),
        bloc.add(removeFromCartCaller),
        bloc.add(addProductCaller),
        bloc.add(buySingleCaller),
      ],
      expect: () => [
        state.copyWith(currentItem: tOrderItem),
        state.copyWith(cart: tOrderItems),
        state,
        state.copyWith(currentItem: tOrderItem),
        // onBuySingle
        state.copyWith(
          currentItem: tOrderItem,
          status: OrderProcessingStatus.loading,
        ),
        state.copyWith(
            currentItem: tOrderItem,
            status: OrderProcessingStatus.error,
            errorMessage: 'Server failure'),
      ],
      verify: (bloc) => [mockPlaceOrderUsecaseCaller()],
    );
  });
}
