abstract interface class Failure {
  final String message;
  Failure({required this.message});
}

class ServerFailure extends Failure {
  ServerFailure({required super.message});
}

class OfflineFailure extends Failure {
  OfflineFailure({required super.message});
}

class EmptyCacheFailure extends Failure {
  EmptyCacheFailure({required super.message});
}