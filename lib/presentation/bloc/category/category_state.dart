part of 'category_bloc.dart';

@freezed
class CategoryState with _$CategoryState {
  const factory CategoryState.initial() = _Initial;
  const factory CategoryState.loading() = _Loading;
  const factory CategoryState.loaded({
    Category? singleCategory,
    @Default([]) List<Category> categories,
    @Default(false) bool canLoadMore,
  }) = _Loaded;
  const factory CategoryState.error(String message) = _Error;
}
