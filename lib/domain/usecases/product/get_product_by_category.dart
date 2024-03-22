import 'package:dartz/dartz.dart';
import 'package:onestore_app/domain/entities/product.dart';
import 'package:onestore_app/domain/entities/collection.dart';
import 'package:onestore_app/domain/repositories/product_repository.dart';
import 'package:onestore_app/utils/failure.dart';

class GetProductsByCategory {
  final ProductRepository repository;

  GetProductsByCategory(this.repository);

  Future<Either<Failure, Collection<Product>>> execute(
    int categoryId, {
    int? page,
    String? authToken,
  }) {
    return repository.getProductsByCategory(
      categoryId,
      page: page,
      authToken: authToken,
    );
  }
}
