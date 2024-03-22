import 'dart:convert';

import 'package:onestore_app/data/models/product_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../dummy_data/dummy_object.dart';
import '../../json_reader.dart';

void main() {
  final tProduct = testProductDetail;
  final tProductModel = testProductModelDetail;
  final tProductJson = json.decode(jsonReader('dummy_data/product.json'));

  group('Entity:', () {
    test('should be valid Product when export to entity', () {
      final result = tProductModel.toEntity();
      expect(result, tProduct);
    });

    test('should be valid ProductModel when import from entity', () {
      final result = ProductModel.fromEntity(tProduct);
      expect(result, tProductModel);
    });
  });

  group('Json/Map:', () {
    test('should be a valid ProductModel when import from json', () {
      final result = ProductModel.fromMap(tProductJson);
      expect(result, tProductModel);
    });

    test('should be a valid Map when export to map', () {
      final result = tProductModel.toMap();
      expect(result, tProductJson);
    });
  });
}
