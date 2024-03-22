import 'package:dartz/dartz.dart';
import 'package:onestore_app/domain/entities/banner.dart';
import 'package:onestore_app/domain/repositories/banner_repository.dart';
import 'package:onestore_app/utils/failure.dart';

class GetBanners {
  final BannerRepository repository;

  GetBanners(this.repository);

  Future<Either<Failure, List<Banner>>> execute() {
    return repository.getBanners();
  }
}
