import 'package:dartz/dartz.dart';
import 'package:flutter_store_fic7/domain/entities/banner.dart';
import 'package:flutter_store_fic7/utils/failure.dart';

abstract class BannerRepository {
  Future<Either<Failure, List<Banner>>> getBanners();
}
