import 'dart:convert';

import 'package:onestore_app/data/models/banner_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../dummy_data/dummy_object.dart';
import '../../json_reader.dart';

void main() {
  const tBannerModel = testBannerModel;
  const tBanner = testBanner;
  final tBannerJson = json.decode(jsonReader('dummy_data/banner.json'));

  group('toEntity:', () {
    test('should be a Banner entity when convert is success', () {
      final result = tBannerModel.toEntity();
      expect(result, tBanner);
    });
  });

  group('map', () {
    test('should be a Banner model when import from map is success', () {
      final result = BannerModel.fromMap(tBannerJson);
      expect(result, tBannerModel);
    });
  });
}
