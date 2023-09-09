import 'package:equatable/equatable.dart';

class ApiResponseModel extends Equatable {
  final int? status;
  final dynamic message;
  final Map<String, dynamic>? data;

  const ApiResponseModel({
    this.status,
    required this.message,
    this.data,
  });

  factory ApiResponseModel.fromMap(Map<String, dynamic> json) =>
      ApiResponseModel(
        status: json["status"],
        message: json["message"],
        data: json["data"],
      );

  @override
  List<Object?> get props => [status, message, data];
}
