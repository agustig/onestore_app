import 'dart:convert';

import 'package:flutter_store_fic7/data/api/remote_api.dart';
import 'package:flutter_store_fic7/data/models/api_response_model.dart';
import 'package:flutter_store_fic7/data/models/collection_model.dart';
import 'package:flutter_store_fic7/data/models/product_model.dart';
import 'package:flutter_store_fic7/utils/exceptions.dart';
import 'package:http/http.dart' as http;

abstract class ProductRemoteDataSource {
  Future<CollectionModel<ProductModel>> getProducts({
    int? page,
    String? authToken,
  });
  Future<CollectionModel<ProductModel>> getProductsByCategory(
    int categoryId, {
    int? page,
    String? authToken,
  });
  Future<ProductModel> getProduct({required int id, String? authToken});
}

class ProductRemoteDataSourceImpl
    with RemoteApi
    implements ProductRemoteDataSource {
  final http.Client client;

  ProductRemoteDataSourceImpl({required this.client});

  @override
  Future<CollectionModel<ProductModel>> getProducts({
    int? page,
    String? authToken,
  }) async {
    final Map<String, String> headers =
        (authToken != null) ? super.authyHeaders(authToken) : super.headers;

    final request = await client.get(
      Uri.parse(super.productPath),
      headers: headers,
    );

    if (request.statusCode == 200) {
      final apiResponse = ApiResponseModel.fromMap(jsonDecode(request.body));
      final rawProducts = apiResponse.data as List<dynamic>;
      final collectionNumber = page ?? 1;
      final collections = rawProducts
          .map((rawProduct) => ProductModel.fromMap(rawProduct))
          .toList();

      return CollectionModel<ProductModel>(
        collectionNumber: collectionNumber,
        collections: collections,
        totalCollections: apiResponse.totalPage ?? 1,
      );
    } else {
      throw ServerException();
    }
  }

  @override
  Future<CollectionModel<ProductModel>> getProductsByCategory(
    int categoryId, {
    int? page,
    String? authToken,
  }) async {
    final Map<String, String> headers =
        (authToken != null) ? super.authyHeaders(authToken) : super.headers;

    final request = await client.get(
      Uri.parse('${super.productPath}?category-id=$categoryId'),
      headers: headers,
    );

    if (request.statusCode == 200) {
      final apiResponse = ApiResponseModel.fromMap(jsonDecode(request.body));
      final rawProducts = apiResponse.data as List<dynamic>;
      final collectionNumber = page ?? 1;
      final collections = rawProducts
          .map((rawProduct) => ProductModel.fromMap(rawProduct))
          .toList();

      return CollectionModel<ProductModel>(
        collectionNumber: collectionNumber,
        collections: collections,
        totalCollections: apiResponse.totalPage ?? 1,
      );
    } else {
      throw ServerException();
    }
  }

  @override
  Future<ProductModel> getProduct({required int id, String? authToken}) async {
    final Map<String, String> headers =
        (authToken != null) ? super.authyHeaders(authToken) : super.headers;

    final request = await client.get(
      Uri.parse('${super.productPath}/$id'),
      headers: headers,
    );

    if (request.statusCode == 200) {
      final apiResponse = ApiResponseModel.fromMap(jsonDecode(request.body));
      return ProductModel.fromMap(apiResponse.data);
    } else {
      throw ServerException();
    }
  }
}
