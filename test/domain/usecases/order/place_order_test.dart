import 'package:dartz/dartz.dart';
import 'package:onestore_app/domain/usecases/order/place_order.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../dummy_data/dummy_object.dart';
import '../../../mock_helper.dart';

void main() {
  late final PlaceOrder usecase;
  late final MockOrderRepository mockRepository;

  final tOrder = testOrder;
  final tOrderItems = [testOrderItem];
  const tAuthToken = 'sdaikwqeuihknjdaf3oiwrnasf';
  const tDeliveryAddress =
      'Jl Angkasa 1 Golden Boutique Hotel Lt Basement and Dasar, Dki Jakarta';

  setUpAll(() {
    mockRepository = MockOrderRepository();
    usecase = PlaceOrder(mockRepository);
  });

  mockRepositoryCaller() => mockRepository.placeOrder(
        items: tOrderItems,
        deliveryAddress: tDeliveryAddress,
        authToken: tAuthToken,
      );

  usecaseCaller() => usecase.execute(
        items: tOrderItems,
        deliveryAddress: tDeliveryAddress,
        authToken: tAuthToken,
      );

  test('should be a return Order entity  when execute is successfully',
      () async {
    // Arrange
    when(() => mockRepositoryCaller()).thenAnswer((_) async => Right(tOrder));
    // Act
    final call = await usecaseCaller();
    // Assert
    verify(() => mockRepositoryCaller());
    expect(call, Right(tOrder));
  });
}
