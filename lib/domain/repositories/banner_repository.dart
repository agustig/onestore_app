import 'package:dartz/dartz.dart';
import 'package:onestore_app/domain/entities/banner.dart';
import 'package:onestore_app/utils/failure.dart';

abstract class BannerRepository {
  Future<Either<Failure, List<Banner>>> getBanners();
}
