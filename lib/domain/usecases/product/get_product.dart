import 'package:dartz/dartz.dart';
import 'package:flutter_store_fic7/domain/entities/product.dart';
import 'package:flutter_store_fic7/domain/repositories/product_repository.dart';
import 'package:flutter_store_fic7/utils/failure.dart';

class GetProduct {
  final ProductRepository repository;

  GetProduct(this.repository);

  Future<Either<Failure, Product>> execute(
      {required int id, String? authToken}) {
    return repository.getProduct(id: id, authToken: authToken);
  }
}
