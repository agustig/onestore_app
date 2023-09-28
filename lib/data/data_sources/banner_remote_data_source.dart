import 'dart:convert';

import 'package:flutter_store_fic7/data/api/remote_api.dart';
import 'package:flutter_store_fic7/data/models/api_response_model.dart';
import 'package:flutter_store_fic7/data/models/banner_model.dart';
import 'package:flutter_store_fic7/utils/exceptions.dart';
import 'package:http/http.dart' as http;

abstract class BannerRemoteDataSource {
  Future<List<BannerModel>> getBanners();
}

class BannerRemoteDataSourceImpl
    with RemoteApi
    implements BannerRemoteDataSource {
  final http.Client client;

  BannerRemoteDataSourceImpl({required this.client});

  @override
  Future<List<BannerModel>> getBanners() async {
    final request =
        await client.get(Uri.parse(super.bannerPath), headers: headers);

    if (request.statusCode == 200) {
      final apiResponse = ApiResponseModel.fromMap(jsonDecode(request.body));
      final rawBanners = apiResponse.data as List<dynamic>;
      return List<BannerModel>.from(
          rawBanners.map((rawBanner) => BannerModel.fromMap(rawBanner)));
    } else {
      throw ServerException();
    }
  }
}
