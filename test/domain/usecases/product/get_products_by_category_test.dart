import 'package:dartz/dartz.dart';
import 'package:onestore_app/domain/usecases/product/get_product_by_category.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../dummy_data/dummy_object.dart';
import '../../../mock_helper.dart';

void main() {
  late final GetProductsByCategory usecase;
  late final MockProductRepository mockRepository;

  const tProductCollection = testProductCollection;

  setUpAll(() {
    mockRepository = MockProductRepository();
    usecase = GetProductsByCategory(mockRepository);
  });

  mockRepositoryCaller() => mockRepository.getProductsByCategory(1);

  usecaseCaller() => usecase.execute(1);

  test(
      'should be a return Collection entity for product when execute is successfully',
      () async {
    // Arrange
    when(() => mockRepositoryCaller())
        .thenAnswer((_) async => const Right(tProductCollection));
    // Act
    final call = await usecaseCaller();
    // Assert
    verify(() => mockRepositoryCaller());
    expect(call, const Right(tProductCollection));
  });
}
