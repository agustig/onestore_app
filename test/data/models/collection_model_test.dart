import 'package:flutter_test/flutter_test.dart';

import '../../dummy_data/dummy_object.dart';

void main() {
  group('toEntity():', () {
    test('should return Collection with category data when convert is success',
        () {
      const tCategoryCollectionModel = testCategoryCollectionModel;
      const tCategoryCollection = testCategoryCollection;
      final result = tCategoryCollectionModel.toEntity();
      expect(result, tCategoryCollection);
    });

    test('should return Collection with product data when convert is success',
        () {
      const tProductCollectionModel = testProductCollectionModel;
      const tProductCollection = testProductCollection;

      final result = tProductCollectionModel.toEntity();
      expect(result, tProductCollection);
    });
  });
}
