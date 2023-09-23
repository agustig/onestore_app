import 'dart:convert';

import 'package:flutter_store_fic7/data/models/order_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../dummy_data/dummy_object.dart';
import '../../json_reader.dart';

void main() {
  final tOrder = testOrder;
  final tOrderModel = testOrderModel;
  final tOrderJson = json.decode(jsonReader('dummy_data/order.json'));

  group('Entity:', () {
    test('should be valid Order when export to entity', () {
      final result = tOrderModel.toEntity();
      expect(result, tOrder);
    });

    test('should be valid OrderModel when import from entity', () {
      final result = OrderModel.fromEntity(tOrder);
      expect(result, tOrderModel);
    });
  });

  group('Json/Map:', () {
    test('should be a valid OrderModel when import from json', () {
      final result = OrderModel.fromMap(tOrderJson);
      expect(result, tOrderModel);
    });

    test('should be a valid Map when export to map', () {
      final result = tOrderModel.toMap();
      expect(result, tOrderJson);
    });
  });
}
