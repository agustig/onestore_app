import 'package:dartz/dartz.dart';
import 'package:flutter_store_fic7/domain/entities/category.dart';
import 'package:flutter_store_fic7/domain/entities/collection.dart';
import 'package:flutter_store_fic7/domain/repositories/category_repository.dart';
import 'package:flutter_store_fic7/utils/failure.dart';

class GetCategories {
  final CategoryRepository repository;

  GetCategories(this.repository);

  Future<Either<Failure, Collection<Category>>> execute({
    int? page,
    String? authToken,
  }) {
    return repository.getCategories(page: page, authToken: authToken);
  }
}
