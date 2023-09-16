part of 'category_bloc.dart';

@freezed
class CategoryEvent with _$CategoryEvent {
  const factory CategoryEvent.getCategory(
    int id, {
    String? authToken,
  }) = _GetCategory;

  const factory CategoryEvent.getCategories({
    String? authToken,
    @Default(false) bool isNext,
  }) = _GetCategories;
}
