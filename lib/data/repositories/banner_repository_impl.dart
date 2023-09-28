import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_store_fic7/data/data_sources/banner_remote_data_source.dart';
import 'package:flutter_store_fic7/domain/entities/banner.dart';
import 'package:flutter_store_fic7/domain/repositories/banner_repository.dart';
import 'package:flutter_store_fic7/utils/exceptions.dart';
import 'package:flutter_store_fic7/utils/failure.dart';

class BannerRepositoryImpl implements BannerRepository {
  final BannerRemoteDataSource dataSource;

  BannerRepositoryImpl(this.dataSource);

  @override
  Future<Either<Failure, List<Banner>>> getBanners() async {
    try {
      final bannersData = await dataSource.getBanners();
      // final bannerEntities =
      //     List<Banner>.from(bannersData.map((model) => model.toEntity()));

      return Right(bannersData.map((e) => e.toEntity()).toList());
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } on ServerException {
      return const Left(ServerFailure('Server Failure'));
    }
  }
}
