import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_store_fic7/presentation/bloc/product/product_bloc.dart';
import 'package:flutter_store_fic7/utils/failure.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../dummy_data/dummy_object.dart';
import '../../../mock_helper.dart';

void main() {
  late ProductBloc productBloc;
  late MockGetProduct mockGetProduct;
  late MockGetProducts mockGetProducts;

  setUp(() {
    mockGetProduct = MockGetProduct();
    mockGetProducts = MockGetProducts();

    productBloc = ProductBloc(
      getProduct: mockGetProduct,
      getProducts: mockGetProducts,
    );
  });

  test(
    'Initial setup should be initial state',
    () => expect(productBloc.state, const ProductState.initial()),
  );

  group('GetProduct event:', () {
    final tProductDetail = testProductDetail;
    blocTest(
      'should return [loading, loaded] when product is loaded successfully',
      build: () {
        when(() => mockGetProduct.execute(id: 1))
            .thenAnswer((_) async => Right(tProductDetail));
        return productBloc;
      },
      act: (bloc) => bloc.add(const ProductEvent.getProduct(1)),
      expect: () => [
        const ProductState.loading(),
        ProductState.loaded(singleProduct: tProductDetail),
      ],
      verify: (bloc) => [mockGetProduct.execute(id: 1)],
    );

    blocTest(
      'should return [loading, loaded] when product loading has get error',
      build: () {
        when(() => mockGetProduct.execute(id: 1)).thenAnswer((_) async =>
            const Left(ConnectionFailure('Failed connect to the Network')));
        return productBloc;
      },
      act: (bloc) => bloc.add(const ProductEvent.getProduct(1)),
      expect: () => [
        const ProductState.loading(),
        const ProductState.error('Failed connect to the Network'),
      ],
      verify: (bloc) => [mockGetProduct.execute(id: 1)],
    );
  });

  group('GetProducts event:', () {
    const tProductCollection = testProductCollection;
    blocTest(
      'should return [loading, loaded] when products is loaded successfully',
      build: () {
        when(() => mockGetProducts.execute())
            .thenAnswer((_) async => const Right(tProductCollection));
        return productBloc;
      },
      act: (bloc) => bloc.add(const ProductEvent.getProducts()),
      expect: () => [
        const ProductState.loading(),
        ProductState.loaded(
          products: tProductCollection.collections,
          canLoadMore: true,
        ),
      ],
      verify: (bloc) => [mockGetProducts.execute()],
    );

    blocTest(
      'should return [loading, loaded] when products loading has get error',
      build: () {
        when(() => mockGetProducts.execute()).thenAnswer((_) async =>
            const Left(ConnectionFailure('Failed connect to the Network')));
        return productBloc;
      },
      act: (bloc) => bloc.add(const ProductEvent.getProducts()),
      expect: () => [
        const ProductState.loading(),
        const ProductState.error('Failed connect to the Network'),
      ],
      verify: (bloc) => [mockGetProducts.execute()],
    );
  });
}
