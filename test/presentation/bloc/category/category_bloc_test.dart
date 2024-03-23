import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:onestore_app/presentation/bloc/category/category_bloc.dart';
import 'package:onestore_app/utils/failure.dart';

import '../../../dummy_data/dummy_object.dart';
import '../../../mock_helper.dart';

void main() {
  late CategoryBloc categoryBloc;
  late MockGetCategory mockGetCategory;
  late MockGetCategories mockGetCategories;

  setUp(() {
    mockGetCategory = MockGetCategory();
    mockGetCategories = MockGetCategories();

    categoryBloc = CategoryBloc(
      getCategory: mockGetCategory,
      getCategories: mockGetCategories,
    );
  });

  test(
    'Initial setup should be initial state',
    () => expect(categoryBloc.state, const CategoryState.initial()),
  );

  group('GetCategory event:', () {
    final tCategoryDetail = testCategoryDetail;
    blocTest(
      'should return [loading, loaded] when category is loaded successfully',
      build: () {
        when(() => mockGetCategory.execute(id: 1))
            .thenAnswer((_) async => Right(tCategoryDetail));
        return categoryBloc;
      },
      act: (bloc) => bloc.add(const CategoryEvent.getCategory(1)),
      expect: () => [
        const CategoryState.loading(),
        CategoryState.loaded(singleCategory: tCategoryDetail),
      ],
      verify: (bloc) => [mockGetCategory.execute(id: 1)],
    );

    blocTest(
      'should return [loading, loaded] when category loading has get error',
      build: () {
        when(() => mockGetCategory.execute(id: 1)).thenAnswer((_) async =>
            const Left(ConnectionFailure('Failed connect to the Network')));
        return categoryBloc;
      },
      act: (bloc) => bloc.add(const CategoryEvent.getCategory(1)),
      expect: () => [
        const CategoryState.loading(),
        const CategoryState.error('Failed connect to the Network'),
      ],
      verify: (bloc) => [mockGetCategory.execute(id: 1)],
    );
  });

  group('GetCategories event:', () {
    const tCategoryCollection = testCategoryCollection;
    blocTest(
      'should return [loading, loaded] when categories is loaded successfully',
      build: () {
        when(() => mockGetCategories.execute())
            .thenAnswer((_) async => const Right(tCategoryCollection));
        return categoryBloc;
      },
      act: (bloc) => bloc.add(const CategoryEvent.getCategories()),
      expect: () => [
        const CategoryState.loading(),
        CategoryState.loaded(categories: tCategoryCollection.collections),
      ],
      verify: (bloc) => [mockGetCategories.execute()],
    );

    blocTest(
      'should return [loading, loaded] when categories loading has get error',
      build: () {
        when(() => mockGetCategories.execute()).thenAnswer((_) async =>
            const Left(ConnectionFailure('Failed connect to the Network')));
        return categoryBloc;
      },
      act: (bloc) => bloc.add(const CategoryEvent.getCategories()),
      expect: () => [
        const CategoryState.loading(),
        const CategoryState.error('Failed connect to the Network'),
      ],
      verify: (bloc) => [mockGetCategories.execute()],
    );
  });
}
