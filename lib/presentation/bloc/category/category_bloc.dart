import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_store_fic7/domain/entities/category.dart';
import 'package:flutter_store_fic7/domain/usecases/category/get_categories.dart';
import 'package:flutter_store_fic7/domain/usecases/category/get_category.dart';
import 'package:flutter_store_fic7/utils/failure.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'category_event.dart';
part 'category_state.dart';
part 'category_bloc.freezed.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final GetCategory _getCategory;
  final GetCategories _getCategories;

  CategoryBloc({
    required GetCategory getCategory,
    required GetCategories getCategories,
  })  : _getCategory = getCategory,
        _getCategories = getCategories,
        super(const _Initial()) {
    on<_GetCategory>(_onGetCategory);
    on<_GetCategories>(_onGetCategories);
  }

  int _currentCollectionNumber = 0;
  List<Category> _loadedCategories = [];

  _onGetCategory(_GetCategory event, Emitter<CategoryState> emit) async {
    _Loaded lastState;
    if (state is _Loaded) {
      lastState = state as _Loaded;
    } else {
      lastState = const _Loaded();
    }

    emit(const _Loading());

    try {
      final result = await _getCategory.execute(
        id: event.id,
        authToken: event.authToken,
      );

      result.fold(
        (failure) => throw failure,
        (category) => emit(lastState.copyWith(singleCategory: category)),
      );
    } on Failure catch (failure) {
      emit(_Error(failure.message));
    }
  }

  _onGetCategories(_GetCategories event, Emitter<CategoryState> emit) async {
    if (state is _Loaded) {
      _loadedCategories = List.from((state as _Loaded).categories);
    }

    emit(const _Loading());

    try {
      final result = await _getCategories.execute(
        page: event.isNext ? _currentCollectionNumber + 1 : null,
        authToken: event.authToken,
      );

      result.fold(
        (failure) => throw failure,
        (categories) {
          _loadedCategories.addAll(categories.collections);
          _currentCollectionNumber = categories.collectionNumber;
          emit(_Loaded(
            categories: _loadedCategories,
            canLoadMore: categories.totalCollections > _currentCollectionNumber,
          ));
        },
      );
    } on Failure catch (failure) {
      emit(_Error(failure.message));
    }
  }
}
