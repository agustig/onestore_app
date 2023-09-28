import 'package:dartz/dartz.dart';
import 'package:flutter_store_fic7/domain/entities/banner.dart';
import 'package:flutter_store_fic7/domain/repositories/banner_repository.dart';
import 'package:flutter_store_fic7/utils/failure.dart';

class GetBanners {
  final BannerRepository repository;

  GetBanners(this.repository);

  Future<Either<Failure, List<Banner>>> execute() {
    return repository.getBanners();
  }
}
