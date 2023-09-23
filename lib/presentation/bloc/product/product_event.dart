part of 'product_bloc.dart';

@freezed
class ProductEvent with _$ProductEvent {
  const factory ProductEvent.getProduct(
    int id, {
    String? authToken,
  }) = _GetProduct;

  const factory ProductEvent.getProducts({
    String? authToken,
    @Default(false) bool isNext,
  }) = _GetProducts;

  const factory ProductEvent.getProductsByCategory(
    Category category, {
    String? authToken,
    @Default(false) bool isNext,
  }) = _GetProductsByCategory;
}
