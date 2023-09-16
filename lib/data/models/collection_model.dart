import 'package:equatable/equatable.dart';
import 'package:flutter_store_fic7/data/models/category_model.dart';
import 'package:flutter_store_fic7/data/models/product_model.dart';
import 'package:flutter_store_fic7/domain/entities/category.dart';
import 'package:flutter_store_fic7/domain/entities/collection.dart';
import 'package:flutter_store_fic7/domain/entities/product.dart';

class CollectionModel<T extends dynamic> extends Equatable {
  final int collectionNumber;
  final List<T> collections;
  final int totalCollections;

  const CollectionModel({
    required this.collectionNumber,
    required this.collections,
    required this.totalCollections,
  });

  Collection toEntity() {
    if (T == CategoryModel) {
      return Collection<Category>(
        collectionNumber: collectionNumber,
        collections: collections
            .map((model) => (model as CategoryModel).toEntity())
            .toList(),
        totalCollections: totalCollections,
      );
    } else {
      return Collection<Product>(
        collectionNumber: collectionNumber,
        collections: collections
            .map((model) => (model as ProductModel).toEntity())
            .toList(),
        totalCollections: totalCollections,
      );
    }
  }

  @override
  List<Object?> get props => [collectionNumber, collections, totalCollections];
}
