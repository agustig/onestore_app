import 'package:dartz/dartz.dart';
import 'package:onestore_app/domain/entities/user.dart';
import 'package:onestore_app/domain/repositories/profile_repository.dart';
import 'package:onestore_app/utils/failure.dart';

class GetProfile {
  final ProfileRepository repository;

  GetProfile(this.repository);

  Future<Either<Failure, User>> execute({required String authToken}) {
    return repository.getProfile(authToken: authToken);
  }
}
