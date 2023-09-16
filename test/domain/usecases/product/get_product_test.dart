import 'package:dartz/dartz.dart';
import 'package:flutter_store_fic7/domain/usecases/product/get_product.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../dummy_data/dummy_object.dart';
import '../../../mock_helper.dart';

void main() {
  late final GetProduct usecase;
  late final MockProductRepository mockRepository;

  final tProductDetail = testProductDetail;

  setUpAll(() {
    mockRepository = MockProductRepository();
    usecase = GetProduct(mockRepository);
  });

  mockRepositoryCaller() => mockRepository.getProduct(id: 1);

  usecaseCaller() => usecase.execute(id: 1);

  test('should be a return Product entity execute is successfully', () async {
    // Arrange
    when(() => mockRepositoryCaller())
        .thenAnswer((_) async => Right(tProductDetail));
    // Act
    final call = await usecaseCaller();
    // Assert
    verify(() => mockRepositoryCaller());
    expect(call, Right(tProductDetail));
  });
}
