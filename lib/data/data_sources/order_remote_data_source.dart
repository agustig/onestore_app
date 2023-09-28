import 'dart:convert';

import 'package:flutter_store_fic7/data/api/remote_api.dart';
import 'package:flutter_store_fic7/data/models/api_response_model.dart';
import 'package:flutter_store_fic7/data/models/order_item_model.dart';
import 'package:flutter_store_fic7/data/models/order_model.dart';
import 'package:flutter_store_fic7/utils/exceptions.dart';
import 'package:http/http.dart' as http;

abstract class OrderRemoteDataSource {
  Future<OrderModel> placeOrder({
    required List<OrderItemModel> items,
    required String deliveryAddress,
    required String authToken,
  });
}

class OrderRemoteDataSourceImpl
    with RemoteApi
    implements OrderRemoteDataSource {
  final http.Client client;

  OrderRemoteDataSourceImpl({required this.client});

  @override
  Future<OrderModel> placeOrder({
    required List<OrderItemModel> items,
    required String deliveryAddress,
    required String authToken,
  }) async {
    final headers = super.authyHeaders(authToken);
    final body = json.encode({
      'items': items.map((item) => item.toCheckoutItem()).toList(),
      'delivery_address': deliveryAddress,
    });

    final request = await client.post(
      Uri.parse(super.orderPath),
      headers: headers,
      body: body,
    );

    final ApiResponseModel apiResponse;

    if (request.statusCode == 200) {
      apiResponse = ApiResponseModel.fromMap(jsonDecode(request.body));
      return OrderModel.fromMap(apiResponse.data!);
    } else if (request.statusCode == 401) {
      throw UnauthorizeException();
    } else {
      throw ServerException();
    }
  }
}
