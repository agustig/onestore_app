import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_store_fic7/data/data_sources/product_remote_data_source.dart';
import 'package:flutter_store_fic7/domain/entities/collection.dart';
import 'package:flutter_store_fic7/domain/entities/product.dart';
import 'package:flutter_store_fic7/domain/repositories/product_repository.dart';
import 'package:flutter_store_fic7/utils/exceptions.dart';
import 'package:flutter_store_fic7/utils/failure.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource dataSource;

  ProductRepositoryImpl(this.dataSource);

  @override
  Future<Either<Failure, Product>> getProduct({
    required int id,
    String? authToken,
  }) async {
    try {
      final productData = await dataSource.getProduct(
        id: id,
        authToken: authToken,
      );

      return Right(productData.toEntity());
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } on ServerException {
      return const Left(ServerFailure('Server Failure'));
    }
  }

  @override
  Future<Either<Failure, Collection<Product>>> getProducts({
    int? page,
    String? authToken,
  }) async {
    try {
      final productsData = await dataSource.getProducts(
        page: page,
        authToken: authToken,
      );

      return Right(productsData.toEntity() as Collection<Product>);
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } on ServerException {
      return const Left(ServerFailure('Server Failure'));
    }
  }

  @override
  Future<Either<Failure, Collection<Product>>> getProductsByCategory(
    int categoryId, {
    int? page,
    String? authToken,
  }) async {
    try {
      final productsData = await dataSource.getProductsByCategory(
        categoryId,
        page: page,
        authToken: authToken,
      );

      return Right(productsData.toEntity() as Collection<Product>);
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } on ServerException {
      return const Left(ServerFailure('Server Failure'));
    }
  }
}
