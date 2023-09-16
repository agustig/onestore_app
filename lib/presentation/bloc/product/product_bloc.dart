import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_store_fic7/domain/entities/product.dart';
import 'package:flutter_store_fic7/domain/usecases/product/get_products.dart';
import 'package:flutter_store_fic7/domain/usecases/product/get_product.dart';
import 'package:flutter_store_fic7/utils/failure.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_event.dart';
part 'product_state.dart';
part 'product_bloc.freezed.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final GetProduct _getProduct;
  final GetProducts _getProducts;

  ProductBloc({
    required GetProduct getProduct,
    required GetProducts getProducts,
  })  : _getProduct = getProduct,
        _getProducts = getProducts,
        super(const _Initial()) {
    on<_GetProduct>(_onGetProduct);
    on<_GetProducts>(_onGetProducts);
  }

  int _currentCollectionNumber = 0;
  List<Product> _loadedProducts = [];

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
    if (state is _Loaded) {
      _loadedProducts = List.from((state as _Loaded).products);
    }

    emit(const _Loading());

    try {
      final result = await _getProducts.execute(
        page: event.isNext ? _currentCollectionNumber + 1 : null,
        authToken: event.authToken,
      );

      result.fold(
        (failure) => throw failure,
        (products) {
          _loadedProducts.addAll(products.collections);
          _currentCollectionNumber = products.collectionNumber;
          emit(_Loaded(
            products: _loadedProducts,
            canLoadMore: products.totalCollections > _currentCollectionNumber,
          ));
        },
      );
    } on Failure catch (failure) {
      emit(_Error(failure.message));
    }
  }
}
