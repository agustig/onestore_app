import 'dart:convert';

import 'package:flutter_store_fic7/data/models/category_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../dummy_data/dummy_object.dart';
import '../../json_reader.dart';

void main() {
  final tCategory = testCategoryDetail;
  final tCategoryModel = testCategoryModelDetail;
  final tCategoryJson = json.decode(jsonReader('dummy_data/category.json'));

  group('Entity:', () {
    test('should be valid Category when export to entity', () {
      final result = tCategoryModel.toEntity();
      expect(result, tCategory);
    });
  });

  group('Json/Map:', () {
    test('should be a valid CategoryModel when import from json', () {
      final result = CategoryModel.fromMap(tCategoryJson);
      expect(result, tCategoryModel);
    });

    test('should be a valid Map when export to map', () {
      final result = tCategoryModel.toMap();
      expect(result, tCategoryJson);
    });
  });
}
