import 'dart:convert';

import 'package:onestore_app/data/data_sources/order_remote_data_source.dart';
import 'package:onestore_app/data/models/order_model.dart';
import 'package:onestore_app/utils/exceptions.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

import '../../dummy_data/dummy_object.dart';
import '../../json_reader.dart';
import '../../mock_helper.dart';

void main() {
  late final OrderRemoteDataSource dataSource;
  late final MockClient mockClient;

  setUpAll(() {
    mockClient = MockClient();
    dataSource = OrderRemoteDataSourceImpl(client: mockClient);
  });

  final mockRemoteApi = MockRemoteApi();

  group('placeOrder function:', () {
    final tOrderModel = OrderModel.fromMap(
      json.decode(jsonReader('dummy_data/order.json')),
    );
    final tOrderItemsModel = [testOrderItemModel];
    final tOrderApiResponseJson = jsonReader(
      'dummy_data/order_api_response.json',
    );

    final tOrderData = json.encode(testOrderData);
    const tAuthToken = 'sdaikwqeuihknjdaf3oiwrnasf';

    dataSourceCaller() => dataSource.placeOrder(
          items: tOrderItemsModel,
          deliveryAddress:
              'Jl Angkasa 1 Golden Boutique Hotel Lt Basement and Dasar, Dki Jakarta',
          authToken: tAuthToken,
        );

    mockApiCaller() => mockClient.post(
          Uri.parse(mockRemoteApi.orderPath),
          headers: mockRemoteApi.authyHeaders(tAuthToken),
          body: tOrderData,
        );

    test('should return OrderModel when the response code is 200', () async {
      // Arrange
      when(() => mockApiCaller())
          .thenAnswer((_) async => http.Response(tOrderApiResponseJson, 200));
      // Act
      final call = await dataSourceCaller();
      // Assert
      expect(call, tOrderModel);
    });

    test(
      'should throw a UnauthorizeException when the response code is 401 or other',
      () async {
        // arrange
        when(() => mockApiCaller()).thenAnswer(
            (_) async => http.Response('{"message": "Unauthorize"}', 401));
        // act
        final call = dataSourceCaller();
        // assert
        expect(() => call, throwsA(isA<UnauthorizeException>()));
      },
    );

    test(
      'should throw a ServerException when the response code is 404 or other',
      () async {
        // arrange
        when(() => mockApiCaller()).thenAnswer(
            (_) async => http.Response('{"message": "Not Found"}', 404));
        // act
        final call = dataSourceCaller();
        // assert
        expect(() => call, throwsA(isA<ServerException>()));
      },
    );
  });
}
