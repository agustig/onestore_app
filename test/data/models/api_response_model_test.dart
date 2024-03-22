import 'dart:convert';

import 'package:onestore_app/data/models/api_response_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../dummy_data/dummy_object.dart';
import '../../json_reader.dart';

void main() {
  const tApiResponse = testApiResponse;
  final tApiResponseJson = json.decode(
    jsonReader('dummy_data/api_response.json'),
  );

  test('should be a valid ApiResponseModel when import from Json/Map', () {
    final result = ApiResponseModel.fromMap(tApiResponseJson);
    expect(result, tApiResponse);
  });
}
