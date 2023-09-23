import 'dart:io';

import 'package:flutter_store_fic7/data/data_sources/auth_local_data_source.dart';
import 'package:flutter_store_fic7/data/data_sources/auth_remote_data_source.dart';
import 'package:flutter_store_fic7/data/data_sources/category_remote_data_source.dart';
import 'package:flutter_store_fic7/data/data_sources/order_remote_data_source.dart';
import 'package:flutter_store_fic7/data/data_sources/product_remote_data_source.dart';
import 'package:flutter_store_fic7/data/repositories/auth_repository_impl.dart';
import 'package:flutter_store_fic7/data/repositories/category_repository_impl.dart';
import 'package:flutter_store_fic7/data/repositories/order_repository_impl.dart';
import 'package:flutter_store_fic7/data/repositories/product_repository_impl.dart';
import 'package:flutter_store_fic7/domain/repositories/auth_repository.dart';
import 'package:flutter_store_fic7/domain/repositories/category_repository.dart';
import 'package:flutter_store_fic7/domain/repositories/order_repository.dart';
import 'package:flutter_store_fic7/domain/repositories/product_repository.dart';
import 'package:flutter_store_fic7/domain/usecases/auth/auth_get_token.dart';
import 'package:flutter_store_fic7/domain/usecases/auth/auth_login.dart';
import 'package:flutter_store_fic7/domain/usecases/auth/auth_logout.dart';
import 'package:flutter_store_fic7/domain/usecases/auth/auth_register.dart';
import 'package:flutter_store_fic7/domain/usecases/auth/auth_remove_token.dart';
import 'package:flutter_store_fic7/domain/usecases/auth/auth_save_token.dart';
import 'package:flutter_store_fic7/domain/usecases/category/get_categories.dart';
import 'package:flutter_store_fic7/domain/usecases/category/get_category.dart';
import 'package:flutter_store_fic7/domain/usecases/order/place_order.dart';
import 'package:flutter_store_fic7/domain/usecases/product/get_product.dart';
import 'package:flutter_store_fic7/domain/usecases/product/get_product_by_category.dart';
import 'package:flutter_store_fic7/domain/usecases/product/get_products.dart';
import 'package:flutter_store_fic7/presentation/bloc/auth/auth_bloc.dart';
import 'package:flutter_store_fic7/presentation/bloc/auth_status/auth_status_bloc.dart';
import 'package:flutter_store_fic7/presentation/bloc/category/category_bloc.dart';
import 'package:flutter_store_fic7/presentation/bloc/order/order_bloc.dart';
import 'package:flutter_store_fic7/presentation/bloc/product/product_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

final locator = GetIt.instance;

void init() {
  // Bloc
  locator.registerFactory(
    () => AuthBloc(
      authLogin: locator(),
      authRegister: locator(),
      authLogout: locator(),
      authSaveToken: locator(),
      authRemoveToken: locator(),
      authGetToken: locator(),
    ),
  );
  locator.registerFactory(() => AuthStatusBloc(locator()));
  locator.registerFactory(
    () => CategoryBloc(
      getCategory: locator(),
      getCategories: locator(),
    ),
  );
  locator.registerFactory(
    () => ProductBloc(
      getProduct: locator(),
      getProducts: locator(),
      getProductsByCategory: locator(),
    ),
  );
  locator.registerFactory(() => OrderBloc(placeOrder: locator()));

  // Usecases
  locator.registerLazySingleton(() => AuthRegister(locator()));
  locator.registerLazySingleton(() => AuthLogin(locator()));
  locator.registerLazySingleton(() => AuthLogout(locator()));
  locator.registerLazySingleton(() => AuthGetToken(locator()));
  locator.registerLazySingleton(() => AuthSaveToken(locator()));
  locator.registerLazySingleton(() => AuthRemoveToken(locator()));
  locator.registerLazySingleton(() => GetCategory(locator()));
  locator.registerLazySingleton(() => GetCategories(locator()));
  locator.registerLazySingleton(() => GetProduct(locator()));
  locator.registerLazySingleton(() => GetProducts(locator()));
  locator.registerLazySingleton(() => GetProductsByCategory(locator()));
  locator.registerLazySingleton(() => PlaceOrder(locator()));

  // Repositories
  locator.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );
  locator.registerLazySingleton<CategoryRepository>(
      () => CategoryRepositoryImpl(locator()));
  locator.registerLazySingleton<ProductRepository>(
      () => ProductRepositoryImpl(locator()));
  locator.registerLazySingleton<OrderRepository>(
      () => OrderRepositoryImpl(locator()));

  // DataSources
  locator.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<AuthLocalDataSource>(
      () => AuthLocalDataSourceImpl(sharedPreferences: locator()));
  locator.registerLazySingleton<CategoryRemoteDataSource>(
      () => CategoryRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<ProductRemoteDataSource>(
      () => ProductRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<OrderRemoteDataSource>(
      () => OrderRemoteDataSourceImpl(client: locator()));

  // External
  locator.registerLazySingleton(() => http.Client());
  locator.registerLazySingletonAsync<SharedPreferences>(
      () async => SharedPreferences.getInstance());
  locator.registerLazySingletonAsync<Directory>(
      () async => getApplicationDocumentsDirectory());
  locator.registerLazySingletonAsync<HydratedStorage>(
      () async => HydratedStorage.build(storageDirectory: locator()));
}
