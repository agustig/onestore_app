import 'dart:convert';

import 'package:flutter_store_fic7/data/models/auth_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../dummy_data/dummy_object.dart';
import '../../json_reader.dart';

void main() {
  const tAuthModel = testAuthModel;
  const tAuth = testAuth;
  final tAuthJson = json.decode(jsonReader('dummy_data/auth.json'));

  group('Entity:', () {
    test('should be a valid Auth when export to entity', () {
      final result = tAuthModel.toEntity();
      expect(result, tAuth);
    });
  });

  group('Map/Json:', () {
    test('should be a valid AuthModel when import from json', () {
      final result = AuthModel.fromMap(tAuthJson);
      expect(result, tAuthModel);
    });
  });
}
