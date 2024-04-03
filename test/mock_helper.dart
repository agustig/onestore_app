import 'package:http/http.dart' as http;
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:onestore_app/data/api/remote_api.dart';
import 'package:onestore_app/data/data_sources/auth_local_data_source.dart';
import 'package:onestore_app/data/data_sources/auth_remote_data_source.dart';
import 'package:onestore_app/data/data_sources/banner_remote_data_source.dart';
import 'package:onestore_app/data/data_sources/category_remote_data_source.dart';
import 'package:onestore_app/data/data_sources/order_remote_data_source.dart';
import 'package:onestore_app/data/data_sources/product_remote_data_source.dart';
import 'package:onestore_app/data/data_sources/profile_remote_data_source.dart';
import 'package:onestore_app/domain/repositories/auth_repository.dart';
import 'package:onestore_app/domain/repositories/banner_repository.dart';
import 'package:onestore_app/domain/repositories/category_repository.dart';
import 'package:onestore_app/domain/repositories/order_repository.dart';
import 'package:onestore_app/domain/repositories/product_repository.dart';
import 'package:onestore_app/domain/usecases/auth/auth_get_token.dart';
import 'package:onestore_app/domain/usecases/auth/auth_login.dart';
import 'package:onestore_app/domain/usecases/auth/auth_logout.dart';
import 'package:onestore_app/domain/usecases/auth/auth_register.dart';
import 'package:onestore_app/domain/usecases/auth/auth_remove_token.dart';
import 'package:onestore_app/domain/usecases/auth/auth_save_token.dart';
import 'package:onestore_app/domain/usecases/banner/get_banners.dart';
import 'package:onestore_app/domain/usecases/category/get_categories.dart';
import 'package:onestore_app/domain/usecases/category/get_category.dart';
import 'package:onestore_app/domain/usecases/order/place_order.dart';
import 'package:onestore_app/domain/usecases/product/get_product.dart';
import 'package:onestore_app/domain/usecases/product/get_product_by_category.dart';
import 'package:onestore_app/domain/usecases/product/get_products.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Mock External
class MockClient extends Mock implements http.Client {}

class MockSharedPreferences extends Mock implements SharedPreferences {}

class MockStorage extends Mock implements Storage {}

// Mock Data Sources
class MockAuthRemoteDataSource extends Mock implements AuthRemoteDataSource {}

class MockAuthLocalDataSource extends Mock implements AuthLocalDataSource {}

class MockCategoryRemoteDataSource extends Mock
    implements CategoryRemoteDataSource {}

class MockProductRemoteDataSource extends Mock
    implements ProductRemoteDataSource {}

class MockOrderRemoteDataSource extends Mock implements OrderRemoteDataSource {}

class MockBannerRemoteDataSource extends Mock
    implements BannerRemoteDataSource {}

class MockProfileRemoteDataSource extends Mock
    implements ProfileRemoteDataSource {}

// Mock Repositories
class MockAuthRepository extends Mock implements AuthRepository {}

class MockCategoryRepository extends Mock implements CategoryRepository {}

class MockProductRepository extends Mock implements ProductRepository {}

class MockOrderRepository extends Mock implements OrderRepository {}

class MockBannerRepository extends Mock implements BannerRepository {}

// Mock Use Cases
class MockAuthRegister extends Mock implements AuthRegister {}

class MockAuthLogin extends Mock implements AuthLogin {}

class MockAuthLogout extends Mock implements AuthLogout {}

class MockAuthGetToken extends Mock implements AuthGetToken {}

class MockAuthRemoveToken extends Mock implements AuthRemoveToken {}

class MockAuthSaveToken extends Mock implements AuthSaveToken {}

class MockGetCategory extends Mock implements GetCategory {}

class MockGetCategories extends Mock implements GetCategories {}

class MockGetProduct extends Mock implements GetProduct {}

class MockGetProducts extends Mock implements GetProducts {}

class MockGetProductsByCategory extends Mock implements GetProductsByCategory {}

class MockPlaceOrder extends Mock implements PlaceOrder {}

class MockGetBanners extends Mock implements GetBanners {}

// Mock Mixins
class MockRemoteApi with RemoteApi {}
