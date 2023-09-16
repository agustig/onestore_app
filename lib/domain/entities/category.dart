import 'package:equatable/equatable.dart';
import 'package:flutter_store_fic7/domain/entities/product.dart';

class Category extends Equatable {
  final int id;
  final String name;
  final String description;
  final List<Product>? products;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const Category({
    required this.id,
    required this.name,
    required this.description,
    this.products,
    this.createdAt,
    this.updatedAt,
  });

  @override
  List<Object?> get props {
    return [
      id,
      name,
      description,
      products,
      createdAt,
      updatedAt,
    ];
  }
}
