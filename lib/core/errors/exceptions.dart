import 'package:dio/dio.dart';

class AppExecption implements Exception {
  final String message;

  const AppExecption(this.message);
}

class ServerException extends AppExecption {
  const ServerException(super.message);

  factory ServerException.fromDioException(DioException e) {
    final String? message = e.response?.data['message'] as String?;
    if (message != null && message.isNotEmpty) {
      return ServerException(message);
    }
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return const ServerException('Connection timeout with api server');
      case DioExceptionType.sendTimeout:
        return const ServerException('Send timeout with ApiServer');
      case DioExceptionType.receiveTimeout:
        return const ServerException('Receive timeout with ApiServer');
      case DioExceptionType.badCertificate:
        return const ServerException('badCertificate with api server');
      case DioExceptionType.badResponse:
        return ServerException.fromResponse(e.response!.statusCode!, e.response!.data);
      case DioExceptionType.cancel:
        return const ServerException('Request to ApiServer was canceld');
      case DioExceptionType.connectionError:
        return const ServerException('No Internet Connection');
      case DioExceptionType.unknown:
        return const ServerException('Opps There was an Error, Please try again');
    }
  }

  factory ServerException.fromResponse(int statusCode, dynamic response) {
    if (statusCode == 404) {
      return const ServerException('Your request was not found, please try later');
    } else if (statusCode == 500) {
      return const ServerException('There is a problem with server, please try later');
    } else if (statusCode == 400 || statusCode == 401 || statusCode == 403) {
      return ServerException(response['error']['message']);
    } else {
      return const ServerException('There was an error , please try again');
    }
  }
}

class EmptyCacheException extends AppExecption {
  EmptyCacheException(super.message);
}

class OfflineException extends AppExecption {
  OfflineException(super.message);
}

class LogoutException extends AppExecption {
  LogoutException(super.message);
}
