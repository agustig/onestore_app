import 'package:equatable/equatable.dart';

import 'package:onestore_app/data/models/category_model.dart';
import 'package:onestore_app/data/models/user_model.dart';
import 'package:onestore_app/domain/entities/product.dart';

class ProductModel extends Equatable {
  final int id;
  final String name;
  final String description;
  final String price;
  final String imageUrl;
  final UserModel? seller;
  final CategoryModel? category;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const ProductModel({
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

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'image_url': imageUrl,
      if (seller != null) 'seller': seller!.toMap(),
      if (category != null) 'category': category!.toMap(),
      if (createdAt != null) 'created_at': createdAt!.toIso8601String(),
      if (updatedAt != null) 'updated_at': updatedAt!.toIso8601String()
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      price: map['price'],
      imageUrl: map['image_url'],
      seller: map['seller'] != null ? UserModel.fromMap(map['seller']) : null,
      category: map['category'] != null
          ? CategoryModel.fromMap(map['category'])
          : null,
      createdAt:
          map['created_at'] != null ? DateTime.parse(map['created_at']) : null,
      updatedAt:
          map['updated_at'] != null ? DateTime.parse(map['updated_at']) : null,
    );
  }

  Product toEntity() {
    return Product(
      id: id,
      name: name,
      description: description,
      price: price,
      imageUrl: imageUrl,
      seller: (seller != null) ? seller!.toEntity() : null,
      category: (category != null) ? category!.toEntity() : null,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  factory ProductModel.fromEntity(Product entity) {
    return ProductModel(
      id: entity.id,
      name: entity.name,
      description: entity.description,
      price: entity.price,
      imageUrl: entity.imageUrl,
      seller:
          (entity.seller != null) ? UserModel.fromEntity(entity.seller!) : null,
      category: (entity.category != null)
          ? CategoryModel.fromEntity(entity.category!)
          : null,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }

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
