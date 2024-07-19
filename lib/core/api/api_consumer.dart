import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopera/core/services/service_locator.dart';
import '../constants/strings.dart';

import '../errors/exceptions.dart';

abstract class ApiConsumer {
  Future<dynamic> get(
    String path, {
    Map<String, dynamic>? query,
  });

  Future<dynamic> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? query,
  });

  Future<dynamic> put(
    String path, {
    dynamic data,
    Map<String, dynamic>? query,
  });

  Future<dynamic> delete(
    String path, {
    dynamic data,
    Map<String, dynamic>? query,
  });

  Future<dynamic> patch(
    String path, {
    dynamic data,
    Map<String, dynamic>? query,
  });
}

class DioConsumer extends ApiConsumer {
  final Dio dio;

  String? get authToken {
    SharedPreferences sharedPreferences = AppDep.sl();
    return sharedPreferences.getString(K_TOKEN);
  }

  DioConsumer({required this.dio}) {
    dio.options = BaseOptions(
      baseUrl: BASE_URL,
      connectTimeout: const Duration(seconds: 5),
      sendTimeout: const Duration(seconds: 3),
      headers: {'Authorization': 'Bearer $authToken'},
    );
  }

  @override
  Future delete(String path, {data, Map<String, dynamic>? query}) async {
    try {
      return await dio.delete(
        path,
        queryParameters: query,
        data: data,
      );
    } on DioException catch (e) {
      throw ServerException.fromDioException(e);
    }
  }

  @override
  Future get(String path, {Map<String, dynamic>? query}) async {
    try {
      Response response = await dio.get(
        path,
        queryParameters: query,
      );

      return response;
    } on DioException catch (e) {
      throw ServerException.fromDioException(e);
    }
  }

  @override
  Future patch(String path, {data, Map<String, dynamic>? query}) async {
    try {
      return await dio.patch(
        path,
        queryParameters: query,
        data: data,
      );
    } on DioException catch (e) {
      throw ServerException.fromDioException(e);
    }
  }

  @override
  Future post(String path, {data, Map<String, dynamic>? query}) async {
    try {
      return await dio.post(
        path,
        queryParameters: query,
        data: data,
      );
    } on DioException catch (e) {
      throw ServerException.fromDioException(e);
    }
  }

  @override
  Future put(String path, {data, Map<String, dynamic>? query}) async {
    try {
      return await dio.put(
        path,
        queryParameters: query,
        data: data,
      );
    } on DioException catch (e) {
      throw ServerException.fromDioException(e);
    }
  }
}
