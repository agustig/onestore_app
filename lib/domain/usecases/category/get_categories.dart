import 'package:dartz/dartz.dart';
import 'package:onestore_app/domain/entities/category.dart';
import 'package:onestore_app/domain/entities/collection.dart';
import 'package:onestore_app/domain/repositories/category_repository.dart';
import 'package:onestore_app/utils/failure.dart';

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
