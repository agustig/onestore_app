import 'package:flutter_store_fic7/data/data_sources/auth_local_data_source.dart';
import 'package:flutter_store_fic7/data/data_sources/auth_remote_data_source.dart';
import 'package:flutter_store_fic7/data/repositories/auth_repository_impl.dart';
import 'package:flutter_store_fic7/domain/repositories/auth_repository.dart';
import 'package:flutter_store_fic7/domain/usecases/auth_get_token.dart';
import 'package:flutter_store_fic7/domain/usecases/auth_login.dart';
import 'package:flutter_store_fic7/domain/usecases/auth_logout.dart';
import 'package:flutter_store_fic7/domain/usecases/auth_register.dart';
import 'package:flutter_store_fic7/domain/usecases/auth_remove_token.dart';
import 'package:flutter_store_fic7/domain/usecases/auth_save_token.dart';
import 'package:flutter_store_fic7/presentation/bloc/auth_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

final locator = GetIt.instance;

void init() {
  // Bloc
  locator.registerFactory(
    () => AuthBloc(
      authLogin: locator(),
      authRegister: locator(),
      authLogout: locator(),
      authGetToken: locator(),
      authSaveToken: locator(),
      authRemoveToken: locator(),
    ),
  );

  // Usecases
  locator.registerLazySingleton(() => AuthRegister(locator()));
  locator.registerLazySingleton(() => AuthLogin(locator()));
  locator.registerLazySingleton(() => AuthLogout(locator()));
  locator.registerLazySingleton(() => AuthGetToken(locator()));
  locator.registerLazySingleton(() => AuthSaveToken(locator()));
  locator.registerLazySingleton(() => AuthRemoveToken(locator()));

  // Repositories
  locator.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  // DataSources
  locator.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<AuthLocalDataSource>(
      () => AuthLocalDataSourceImpl(sharedPreferences: locator()));

  // External
  locator.registerLazySingleton(() => http.Client());
  locator.registerLazySingletonAsync<SharedPreferences>(
    () async => SharedPreferences.getInstance(),
  );
}
