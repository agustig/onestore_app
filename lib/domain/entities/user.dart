import 'package:equatable/equatable.dart';

class User extends Equatable {
  final int id;
  final String name;
  final String? email;
  final String? role;
  final String? phone;
  final String? bio;

  const User({
    required this.id,
    required this.name,
    this.email,
    this.role,
    this.phone,
    this.bio,
  });

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
