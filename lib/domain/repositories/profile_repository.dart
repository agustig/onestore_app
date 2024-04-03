import 'package:dartz/dartz.dart';
import 'package:onestore_app/domain/entities/user.dart';
import 'package:onestore_app/utils/failure.dart';

abstract class ProfileRepository {
  Future<Either<Failure, User>> getProfile({required String authToken});
  Future<Either<Failure, User>> updateProfile({required String authToken});
}
