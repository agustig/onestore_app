import 'package:dartz/dartz.dart';
import 'package:onestore_app/domain/entities/category.dart';
import 'package:onestore_app/domain/repositories/category_repository.dart';
import 'package:onestore_app/utils/failure.dart';

class GetCategory {
  final CategoryRepository repository;

  GetCategory(this.repository);

  Future<Either<Failure, Category>> execute(
      {required int id, String? authToken}) {
    return repository.getCategory(id: id, authToken: authToken);
  }
}
