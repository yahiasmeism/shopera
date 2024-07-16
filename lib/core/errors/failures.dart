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

class EmptyLocalStorageFailure extends Failure {
  EmptyLocalStorageFailure({required super.message});
}