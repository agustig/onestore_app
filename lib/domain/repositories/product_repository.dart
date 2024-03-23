import 'package:dartz/dartz.dart';
import 'package:onestore_app/domain/entities/collection.dart';
import 'package:onestore_app/domain/entities/product.dart';
import 'package:onestore_app/utils/failure.dart';

abstract class ProductRepository {
  Future<Either<Failure, Product>> getProduct({
    required int id,
    String? authToken,
  });

  Future<Either<Failure, Collection<Product>>> getProducts({
    int? page,
    String? authToken,
  });

  Future<Either<Failure, Collection<Product>>> getProductsByCategory(
    int categoryId, {
    int? page,
    String? authToken,
  });
}
