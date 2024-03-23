import 'package:dartz/dartz.dart';
import 'package:onestore_app/domain/entities/category.dart';
import 'package:onestore_app/domain/entities/collection.dart';
import 'package:onestore_app/utils/failure.dart';

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
