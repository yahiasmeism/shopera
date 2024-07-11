import 'package:dio/dio.dart';

import '../errors/exceptions.dart';

abstract class ApiConsumer {
  Future<dynamic> get(
    String path, {
    Map<String, dynamic>? query,
    String? token,
  });

  Future<dynamic> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? query,
    String? token,
  });

  Future<dynamic> put(
    String path, {
    dynamic data,
    Map<String, dynamic>? query,
    String? token,
  });

  Future<dynamic> delete(
    String path, {
    dynamic data,
    Map<String, dynamic>? query,
    String? token,
  });

  Future<dynamic> patch(
    String path, {
    dynamic data,
    Map<String, dynamic>? query,
    String? token,
  });
}

class DioConsumer extends ApiConsumer {
  final Dio dio;

  DioConsumer({required this.dio}) {
    dio.options = BaseOptions(
      baseUrl: 'https://dummyjson.com/',
      connectTimeout: const Duration(seconds: 5),
      sendTimeout: const Duration(seconds: 3),
    );
  }

  @override
  Future delete(String path,
      {data, Map<String, dynamic>? query, String? token}) async {
    try {
      return await dio.delete(
        path,
        queryParameters: query,
        data: data,
      );
    } on DioException catch (e) {
      throw mapDioExceptionToServerException(e);
    }
  }

  @override
  Future get(String path, {Map<String, dynamic>? query, String? token}) async {
    try {
      Response response = await dio.get(
        path,
        queryParameters: query,
      );

      return response;
    } on DioException catch (e) {
      throw mapDioExceptionToServerException(e);
    }
  }

  @override
  Future patch(String path,
      {data, Map<String, dynamic>? query, String? token}) async {
    try {
      return await dio.patch(
        path,
        queryParameters: query,
        data: data,
      );
    } on DioException catch (e) {
      throw mapDioExceptionToServerException(e);
    }
  }

  @override
  Future post(String path,
      {data, Map<String, dynamic>? query, String? token}) async {
    try {
      return await dio.post(
        path,
        queryParameters: query,
        data: data,
      );
    } on DioException catch (e) {
      throw mapDioExceptionToServerException(e);
    }
  }

  @override
  Future put(String path,
      {data, Map<String, dynamic>? query, String? token}) async {
    try {
      return await dio.put(
        path,
        queryParameters: query,
        data: data,
      );
    } on DioException catch (e) {
      throw mapDioExceptionToServerException(e);
    }
  }

  ServerException mapDioExceptionToServerException(DioException e) {
    return ServerException.fromDioException(e);
  }
}
