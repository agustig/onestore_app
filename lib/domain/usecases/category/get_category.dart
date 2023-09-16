import 'package:dartz/dartz.dart';
import 'package:flutter_store_fic7/domain/entities/category.dart';
import 'package:flutter_store_fic7/domain/repositories/category_repository.dart';
import 'package:flutter_store_fic7/utils/failure.dart';

class GetCategory {
  final CategoryRepository repository;

  GetCategory(this.repository);

  Future<Either<Failure, Category>> execute(
      {required int id, String? authToken}) {
    return repository.getCategory(id: id, authToken: authToken);
  }
}
