import 'dart:convert';

import 'package:flutter_store_fic7/data/models/order_item_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../dummy_data/dummy_object.dart';
import '../../json_reader.dart';

void main() {
  final tOrderItem = testOrderItem;
  final tOrderItemModel = testOrderItemModel;
  final tOrderItemJson = json.decode(jsonReader('dummy_data/order_item.json'));

  group('Entity:', () {
    test('should be valid OrderItem when export to entity', () {
      final result = tOrderItemModel.toEntity();
      expect(result, tOrderItem);
    });

    test('should be valid OrderItemModel when import from entity', () {
      final result = OrderItemModel.fromEntity(tOrderItem);
      expect(result, tOrderItemModel);
    });
  });

  group('Json/Map:', () {
    test('should be a valid OrderItemModel when import from json', () {
      final result = OrderItemModel.fromMap(tOrderItemJson);
      expect(result, tOrderItemModel);
    });

    test('should be a valid Map when export to map', () {
      final result = tOrderItemModel.toMap();
      expect(result, tOrderItemJson);
    });
  });

  group('toCheckoutItem():', () {
    final tCheckoutData = {"id": 7, "quantity": 1};
    test('should be a valid Map when export to map', () {
      final result = tOrderItemModel.toCheckoutItem();
      expect(result, tCheckoutData);
    });
  });
}
