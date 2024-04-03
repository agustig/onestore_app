import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:onestore_app/data/api/remote_api.dart';
import 'package:onestore_app/data/models/api_response_model.dart';
import 'package:onestore_app/data/models/user_model.dart';
import 'package:onestore_app/utils/exceptions.dart';

abstract class ProfileRemoteDataSource {
  Future<UserModel> getProfile({required String authToken});
  Future<UserModel> updateProfile({required String authToken});
}

class ProfileRemoteDataSourceImpl
    with RemoteApi
    implements ProfileRemoteDataSource {
  final http.Client client;

  ProfileRemoteDataSourceImpl({required this.client});

  @override
  Future<UserModel> getProfile({required String authToken}) async {
    final headers = super.authyHeaders(authToken);

    final request = await client.get(
      Uri.parse(super.profilePath),
      headers: headers,
    );

    final ApiResponseModel apiResponse;

    if (request.statusCode == 200) {
      apiResponse = ApiResponseModel.fromMap(jsonDecode(request.body));
      return UserModel.fromMap(apiResponse.data!);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<UserModel> updateProfile({required String authToken}) {
    // TODO: implement updateUser
    throw UnimplementedError();
  }
}
