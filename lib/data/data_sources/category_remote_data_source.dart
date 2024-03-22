import 'dart:convert';

import 'package:onestore_app/data/api/remote_api.dart';
import 'package:onestore_app/data/models/api_response_model.dart';
import 'package:onestore_app/data/models/category_model.dart';
import 'package:onestore_app/data/models/collection_model.dart';
import 'package:onestore_app/utils/exceptions.dart';
import 'package:http/http.dart' as http;

abstract class CategoryRemoteDataSource {
  Future<CollectionModel> getCategories({int? page, String? authToken});
  Future<CategoryModel> getCategory({required int id, String? authToken});
}

class CategoryRemoteDataSourceImpl
    with RemoteApi
    implements CategoryRemoteDataSource {
  final http.Client client;

  CategoryRemoteDataSourceImpl({required this.client});

  @override
  Future<CollectionModel> getCategories({int? page, String? authToken}) async {
    final Map<String, String> headers =
        (authToken != null) ? super.authyHeaders(authToken) : super.headers;
    final request =
        await client.get(Uri.parse(super.categoryPath), headers: headers);

    if (request.statusCode == 200) {
      final apiResponse = ApiResponseModel.fromMap(jsonDecode(request.body));
      final rawCategories = apiResponse.data as List<dynamic>;
      final collectionNumber = page ?? 1;
      final collections = rawCategories
          .map((rawCategory) => CategoryModel.fromMap(rawCategory))
          .toList();

      return CollectionModel<CategoryModel>(
        collectionNumber: collectionNumber,
        collections: collections,
        totalCollections: apiResponse.totalPage ?? 1,
      );
    } else {
      throw ServerException();
    }
  }

  @override
  Future<CategoryModel> getCategory(
      {required int id, String? authToken}) async {
    final Map<String, String> headers =
        (authToken != null) ? super.authyHeaders(authToken) : super.headers;
    final request = await client.get(Uri.parse('${super.categoryPath}/$id'),
        headers: headers);

    if (request.statusCode == 200) {
      final apiResponse = ApiResponseModel.fromMap(jsonDecode(request.body));
      return CategoryModel.fromMap(apiResponse.data);
    } else {
      throw ServerException();
    }
  }
}
