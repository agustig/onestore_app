import 'dart:convert';

import 'package:flutter_store_fic7/data/models/user_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../dummy_data/dummy_object.dart';
import '../../json_reader.dart';

void main() {
  const tUserModel = testUserModel;
  const tUser = testUser;
  final tUserJson = json.decode(jsonReader('dummy_data/user.json'));

  group('Entity:', () {
    test('should be valid User when export to entity', () {
      final result = tUserModel.toEntity();
      expect(result, tUser);
    });

    test('should be valid UserModel when import from entity', () {
      final result = UserModel.fromEntity(tUser);
      expect(result, tUserModel);
    });
  });

  group('Json/Map:', () {
    test('should be a valid UserModel when import from json', () {
      final result = UserModel.fromMap(tUserJson);
      expect(result, tUserModel);
    });

    test('should be a valid Map when export to map', () {
      final result = tUserModel.toMap();
      expect(result, tUserJson);
    });
  });
}
