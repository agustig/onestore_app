import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onestore_app/domain/entities/category.dart';
import 'package:onestore_app/domain/entities/product.dart';
import 'package:onestore_app/domain/usecases/product/get_product_by_category.dart';
import 'package:onestore_app/domain/usecases/product/get_products.dart';
import 'package:onestore_app/domain/usecases/product/get_product.dart';
import 'package:onestore_app/utils/failure.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_event.dart';
part 'product_state.dart';
part 'product_bloc.freezed.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final GetProduct _getProduct;
  final GetProducts _getProducts;
  final GetProductsByCategory _getProductsByCategory;

  ProductBloc({
    required GetProduct getProduct,
    required GetProducts getProducts,
    required GetProductsByCategory getProductsByCategory,
  })  : _getProduct = getProduct,
        _getProducts = getProducts,
        _getProductsByCategory = getProductsByCategory,
        super(const _Initial()) {
    on<_GetProduct>(_onGetProduct);
    on<_GetProducts>(_onGetProducts);
    on<_GetProductsByCategory>(_onGetProductsByCategory);
  }

  _onGetProduct(_GetProduct event, Emitter<ProductState> emit) async {
    _Loaded lastState;
    if (state is _Loaded) {
      lastState = state as _Loaded;
    } else {
      lastState = const _Loaded();
    }

    emit(const _Loading());

    try {
      final result = await _getProduct.execute(
        id: event.id,
        authToken: event.authToken,
      );

      result.fold(
        (failure) => throw failure,
        (product) => emit(lastState.copyWith(singleProduct: product)),
      );
    } on Failure catch (failure) {
      emit(_Error(failure.message));
    }
  }

  _onGetProducts(_GetProducts event, Emitter<ProductState> emit) async {
    int currentCollectionNumber = 0;
    List<Product> loadedProducts = [];

    if (event.isNext && state is _Loaded) {
      loadedProducts = List.from((state as _Loaded).products);
    }

    emit(const _Loading());

    try {
      final result = await _getProducts.execute(
        page: event.isNext ? currentCollectionNumber + 1 : null,
        authToken: event.authToken,
      );

      result.fold(
        (failure) => throw failure,
        (products) {
          loadedProducts.addAll(products.collections);
          currentCollectionNumber = products.collectionNumber;
          emit(_Loaded(
            products: loadedProducts,
            canLoadMore: products.totalCollections > currentCollectionNumber,
          ));
        },
      );
    } on Failure catch (failure) {
      emit(_Error(failure.message));
    }
  }

  _onGetProductsByCategory(
    _GetProductsByCategory event,
    Emitter<ProductState> emit,
  ) async {
    int currentCollectionNumber = 0;
    List<Product> loadedProducts = [];
    if (event.isNext && state is _Loaded) {
      loadedProducts = List.from((state as _Loaded).products);
    }

    emit(const _Loading());

    try {
      final result = await _getProductsByCategory.execute(
        event.category.id,
        page: event.isNext ? currentCollectionNumber + 1 : null,
        authToken: event.authToken,
      );

      result.fold(
        (failure) => throw failure,
        (products) {
          loadedProducts.addAll(products.collections);
          currentCollectionNumber = products.collectionNumber;

          emit(_Loaded(
            products: loadedProducts,
            canLoadMore: products.totalCollections > currentCollectionNumber,
          ));
        },
      );
    } on Failure catch (failure) {
      emit(_Error(failure.message));
    }
  }
}
