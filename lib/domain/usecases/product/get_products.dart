import 'package:dartz/dartz.dart';
import 'package:onestore_app/domain/entities/product.dart';
import 'package:onestore_app/domain/entities/collection.dart';
import 'package:onestore_app/domain/repositories/product_repository.dart';
import 'package:onestore_app/utils/failure.dart';

class GetProducts {
  final ProductRepository repository;

  GetProducts(this.repository);

  Future<Either<Failure, Collection<Product>>> execute({
    int? page,
    String? authToken,
  }) {
    return repository.getProducts(page: page, authToken: authToken);
  }
}
