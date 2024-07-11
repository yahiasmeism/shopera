import 'package:dio/dio.dart';

class EmptyCacheException implements Exception {
  final String message;

  EmptyCacheException({required this.message});
}

class OfflineException implements Exception {
  final String message;

  OfflineException({required this.message});
}

class ServerException implements Exception {
  const ServerException({required this.message});
  final String message;
  factory ServerException.fromDioException(DioException e) {
    final String? message = e.response?.data['message'] as String?;
    if (message != null && message.isNotEmpty) {
      return ServerException(message: message);
    }
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return const ServerException(
            message: 'Connection timeout check internet');
      case DioExceptionType.sendTimeout:
        return const ServerException(
            message: 'Send timeout check internet connection');
      case DioExceptionType.receiveTimeout:
        return const ServerException(message: 'Receive timeout check internet connection');
      case DioExceptionType.badCertificate:
        return const ServerException(message: 'badCertificate with api server');
      case DioExceptionType.badResponse:
        return ServerException._fromResponse(
            e.response!.statusCode!, e.response!.data);
      case DioExceptionType.cancel:
        return const ServerException(
            message: 'Request to ApiServer was canceld');
      case DioExceptionType.connectionError:
        return const ServerException(message: 'No Internet Connection');
      case DioExceptionType.unknown:
        return const ServerException(
            message: 'Opps There was an Error, Please try again');
    }
  }

  factory ServerException._fromResponse(int statusCode, dynamic response) {
    if (statusCode == 404) {
      return const ServerException(
          message: 'Your request was not found, please try later');
    } else if (statusCode == 500) {
      return const ServerException(
          message: 'There is a problem with server, please try later');
    } else if (statusCode == 400 || statusCode == 401 || statusCode == 403) {
      return ServerException(message: response['error']['message']);
    } else {
      return const ServerException(
          message: 'There was an error , please try again');
    }
  }
}
