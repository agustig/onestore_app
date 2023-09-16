import 'package:equatable/equatable.dart';

import 'package:flutter_store_fic7/domain/entities/category.dart';
import 'package:flutter_store_fic7/domain/entities/user.dart';

class Product extends Equatable {
  final int id;
  final String name;
  final String description;
  final String price;
  final String imageUrl;
  final User? seller;
  final Category? category;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.seller,
    this.category,
    this.createdAt,
    this.updatedAt,
  });

  @override
  List<Object?> get props {
    return [
      id,
      name,
      description,
      price,
      imageUrl,
      seller,
      category,
      createdAt,
      updatedAt,
    ];
  }
}
