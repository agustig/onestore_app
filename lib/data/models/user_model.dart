import 'package:equatable/equatable.dart';
import 'package:onestore_app/domain/entities/user.dart';

class UserModel extends Equatable {
  final int id;
  final String name;
  final String? email;
  final String? role;
  final String? phone;
  final String? bio;

  const UserModel({
    required this.id,
    required this.name,
    this.email,
    this.role,
    this.phone,
    this.bio,
  });

  User toEntity() {
    return User(
      id: id,
      name: name,
      email: email,
      role: role,
      phone: phone,
      bio: bio,
    );
  }

  factory UserModel.fromEntity(User entity) {
    return UserModel(
      id: entity.id,
      name: entity.name,
      email: entity.email,
      role: entity.role,
      phone: entity.phone,
      bio: entity.bio,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      if (email != null) 'email': email,
      if (role != null) 'role': role,
      if (phone != null) 'phone': phone,
      if (bio != null) 'bio': bio,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] as int,
      name: map['name'] as String,
      email: map['email'],
      role: map['role'],
      phone: map['phone'],
      bio: map['bio'],
    );
  }

  @override
  List<Object?> get props {
    return [
      id,
      name,
      email,
      role,
      phone,
      bio,
    ];
  }
}
