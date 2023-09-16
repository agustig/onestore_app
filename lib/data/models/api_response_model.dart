import 'package:equatable/equatable.dart';

class ApiResponseModel extends Equatable {
  final int? status;
  final dynamic message;
  final dynamic data;
  final int? totalPage;

  const ApiResponseModel({
    this.status,
    required this.message,
    this.data,
    this.totalPage,
  });

  factory ApiResponseModel.fromMap(Map<String, dynamic> json) =>
      ApiResponseModel(
        status: json["status"],
        message: json["message"],
        data: json["data"],
        totalPage: json["total_page"],
      );

  @override
  List<Object?> get props => [status, message, data, totalPage];
}
