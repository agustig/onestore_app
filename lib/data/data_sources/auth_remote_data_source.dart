import 'dart:convert';

import 'package:flutter_store_fic7/data/api/base_api.dart';
import 'package:flutter_store_fic7/data/models/api_response_model.dart';
import 'package:flutter_store_fic7/data/models/auth_model.dart';
import 'package:flutter_store_fic7/utils/exceptions.dart';
import 'package:http/http.dart' as http;

abstract class AuthRemoteDataSource {
  Future<AuthModel> login({
    required String email,
    required String password,
  });

  Future<AuthModel> register({
    required String name,
    required String email,
    required String password,
    required String passwordConfirmation,
  });

  Future<bool> logout(String authToken);
}

class AuthRemoteDataSourceImpl extends BaseApi implements AuthRemoteDataSource {
  final http.Client client;

  AuthRemoteDataSourceImpl({required this.client});

  @override
  Future<AuthModel> login({
    required String email,
    required String password,
  }) async {
    final body = json.encode({
      'email': email,
      'password': password,
    });

    final request = await client.post(
      Uri.parse(super.loginPath),
      headers: super.headers,
      body: body,
    );

    final ApiResponseModel apiResponse;

    if (request.statusCode == 200) {
      apiResponse = ApiResponseModel.fromMap(jsonDecode(request.body));
      return AuthModel.fromMap(apiResponse.data!);
    } else if (request.statusCode == 400 || request.statusCode == 422) {
      apiResponse = ApiResponseModel.fromMap(jsonDecode(request.body));
      throw ValidatorException(apiResponse.message);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<AuthModel> register({
    required String name,
    required String email,
    required String password,
    required String passwordConfirmation,
  }) async {
    final body = json.encode({
      'name': name,
      'email': email,
      'password': password,
      'password_confirmation': passwordConfirmation,
    });

    final request = await client.post(
      Uri.parse(super.registerPath),
      headers: super.headers,
      body: body,
    );

    final ApiResponseModel apiResponse;

    if (request.statusCode == 200) {
      apiResponse = ApiResponseModel.fromMap(jsonDecode(request.body));
      return AuthModel.fromMap(apiResponse.data!);
    } else if (request.statusCode == 400) {
      apiResponse = ApiResponseModel.fromMap(jsonDecode(request.body));
      throw ValidatorException(apiResponse.message);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<bool> logout(String authToken) async {
    final request = await client.post(
      Uri.parse(super.logoutPath),
      headers: super.authyHeaders(authToken),
    );

    if (request.statusCode == 200) {
      return true;
    } else {
      throw ServerException();
    }
  }
}
