import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable implements Exception {
  const Failure({
    this.message,
    this.status = 400,
    this.cause,
  });

  factory Failure.unexpected({Exception? cause}) =>
      UnexpectedFailure(cause: cause);

  final String? message;
  final int status;
  final Exception? cause;

  @override
  String toString() => '$runtimeType: $message, status: $status';

  @override
  List<Object?> get props => [
        message,
        cause,
      ];
}

class UnexpectedFailure extends Failure {
  const UnexpectedFailure({super.cause})
      : super(message: 'An unexpected error has occurred');
}

class ApiFailure extends Failure {
  const ApiFailure({
    required String super.message,
    required super.status,
    super.cause,
  });
}

class LaunchFailure extends Failure {
  const LaunchFailure({super.cause})
      : super(message: 'An unexpected error has occurred');
}

class ConnectionFailure extends Failure {
  const ConnectionFailure({super.cause})
      : super(message: 'Request failed not connected!');
}
