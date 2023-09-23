import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;
  const Failure(this.message);
}

class ServerFailure extends Failure {
  const ServerFailure(super.message);

  @override
  List<Object?> get props => [super.message];
}

class ConnectionFailure extends Failure {
  const ConnectionFailure(super.message);

  @override
  List<Object?> get props => [super.message];
}

class UnauthorizeFailure extends Failure {
  const UnauthorizeFailure(super.message);

  @override
  List<Object?> get props => [super.message];
}

class ValidatorFailure extends Failure {
  final Map<String, List<String>> messages;
  const ValidatorFailure(this.messages) : super('');

  @override
  List<Object?> get props => [super.message, messages];
}

class DatabaseFailure extends Failure {
  const DatabaseFailure(super.message);

  @override
  List<Object?> get props => [
        super.message,
      ];
}
