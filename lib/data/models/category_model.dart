import 'package:equatable/equatable.dart';
import 'package:flutter_store_fic7/data/models/product_model.dart';
import 'package:flutter_store_fic7/domain/entities/category.dart';

class CategoryModel extends Equatable {
  final int id;
  final String name;
  final String description;
  final List<ProductModel>? products;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const CategoryModel({
    required this.id,
    required this.name,
    required this.description,
    this.products,
    this.createdAt,
    this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
      if (products != null)
        'products': products!.map((product) => product.toMap()).toList(),
      if (createdAt != null) 'created_at': createdAt!.toIso8601String(),
      if (updatedAt != null) 'updated_at': updatedAt!.toIso8601String(),
    };
  }

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    final rawProducts = map['products'] as List<dynamic>?;
    return CategoryModel(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      products:
          rawProducts?.map((product) => ProductModel.fromMap(product)).toList(),
      createdAt:
          map['created_at'] != null ? DateTime.parse(map['created_at']) : null,
      updatedAt:
          map['updated_at'] != null ? DateTime.parse(map['updated_at']) : null,
    );
  }

  Category toEntity() {
    return Category(
      id: id,
      name: name,
      description: description,
      products: products?.map((product) => product.toEntity()).toList(),
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

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
