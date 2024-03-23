import 'package:dartz/dartz.dart';
import 'package:onestore_app/domain/usecases/product/get_products.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../dummy_data/dummy_object.dart';
import '../../../mock_helper.dart';

void main() {
  late final GetProducts usecase;
  late final MockProductRepository mockRepository;

  const tProductCollection = testProductCollection;

  setUpAll(() {
    mockRepository = MockProductRepository();
    usecase = GetProducts(mockRepository);
  });

  mockRepositoryCaller() => mockRepository.getProducts();

  usecaseCaller() => usecase.execute();

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
