import 'package:dartz/dartz.dart';
import 'package:flutter_store_fic7/domain/entities/category.dart';
import 'package:flutter_store_fic7/domain/entities/collection.dart';
import 'package:flutter_store_fic7/utils/failure.dart';

abstract class CategoryRepository {
  Future<Either<Failure, Collection<Category>>> getCategories({
    int? page,
    String? authToken,
  });

  Future<Either<Failure, Category>> getCategory({
    required int id,
    String? authToken,
  });
}
