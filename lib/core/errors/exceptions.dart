class ServerException implements Exception {
  final String message;
  const ServerException({required this.message});
}

class EmptyCacheException implements Exception {
  final String message;

  EmptyCacheException({required this.message});
}

class OfflineException implements Exception {
  final String message;

  OfflineException({required this.message});
}