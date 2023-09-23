import 'package:dartz/dartz.dart';
import 'package:flutter_store_fic7/domain/entities/product.dart';
import 'package:flutter_store_fic7/domain/entities/collection.dart';
import 'package:flutter_store_fic7/domain/repositories/product_repository.dart';
import 'package:flutter_store_fic7/utils/failure.dart';

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
