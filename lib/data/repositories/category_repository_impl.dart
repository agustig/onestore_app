import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:onestore_app/data/data_sources/category_remote_data_source.dart';
import 'package:onestore_app/domain/entities/collection.dart';
import 'package:onestore_app/domain/entities/category.dart';
import 'package:onestore_app/domain/repositories/category_repository.dart';
import 'package:onestore_app/utils/exceptions.dart';
import 'package:onestore_app/utils/failure.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final CategoryRemoteDataSource dataSource;

  CategoryRepositoryImpl(this.dataSource);

  @override
  Future<Either<Failure, Category>> getCategory({
    required int id,
    String? authToken,
  }) async {
    try {
      final categoryData =
          await dataSource.getCategory(id: id, authToken: authToken);
      return Right(categoryData.toEntity());
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } on ServerException {
      return const Left(ServerFailure('Server Failure'));
    }
  }

  @override
  Future<Either<Failure, Collection<Category>>> getCategories({
    int? page,
    String? authToken,
  }) async {
    try {
      final categoriesData =
          await dataSource.getCategories(page: page, authToken: authToken);
      return Right(categoriesData.toEntity() as Collection<Category>);
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } on ServerException {
      return const Left(ServerFailure('Server Failure'));
    }
  }
}
