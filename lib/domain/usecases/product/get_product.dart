import 'package:dartz/dartz.dart';
import 'package:onestore_app/domain/entities/product.dart';
import 'package:onestore_app/domain/repositories/product_repository.dart';
import 'package:onestore_app/utils/failure.dart';

class GetProduct {
  final ProductRepository repository;

  GetProduct(this.repository);

  Future<Either<Failure, Product>> execute(
      {required int id, String? authToken}) {
    return repository.getProduct(id: id, authToken: authToken);
  }
}
