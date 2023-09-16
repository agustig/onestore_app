import 'package:equatable/equatable.dart';
import 'package:flutter_store_fic7/data/models/user_model.dart';
import 'package:flutter_store_fic7/domain/entities/auth.dart';

class AuthModel extends Equatable {
  final String token;
  final UserModel user;

  const AuthModel({required this.token, required this.user});

  factory AuthModel.fromMap(Map<String, dynamic> map) {
    return AuthModel(
      token: map['auth_token'],
      user: UserModel.fromMap(map['user'] as Map<String, dynamic>),
    );
  }

  Auth toEntity() {
    return Auth(token: token, user: user.toEntity());
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'auth_token': token,
      'user': user.toMap(),
    };
  }

  @override
  List<Object?> get props => [token, user];
}
