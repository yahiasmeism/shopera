import 'package:dio/dio.dart';
import 'package:shopera/core/api/api_consumer.dart';
import 'package:shopera/core/constants/strings.dart';
import 'package:shopera/core/errors/exceptions.dart';
import 'package:shopera/core/constants/end_points.dart';
import 'package:shopera/features/authentication/data/models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> login(String userName, String password);
  Future<UserModel> register(String userName, String email, String password);
  Future<UserModel> updateUser(UserModel user);
}

class AuthRemoteDataSourceImpl extends AuthRemoteDataSource {
  final ApiConsumer api;

  AuthRemoteDataSourceImpl({required this.api});

  @override
  Future<UserModel> login(String userName, String password) async {
    try {

      final response = await api.post(LOGIN, data: {
        'username': userName,
        'password': password,
      });

      return UserModel.fromJson(response.data);
    } on DioException catch (e) {
      if (e.response?.statusCode == 400) {
        // final String errorMessage = e.response?.data["message"];

        throw const ServerException(message: INVALID_CREDENTIALS);
      } else {
        throw const ServerException(message: UNEXPECTED_ERROR);
      }
    }
  }

  @override
  Future<UserModel> register(
      String userName, String email, String password) async {
    final response = await api.post( REGISTER, data: {
      'username': userName,
      'email': email,
      'password': password,
    });

    return UserModel.fromJson(response.data);
  }

  @override
  Future<UserModel> updateUser(UserModel user) async {
    try {
      final response = await api.put(
         UPDATE_PROFILE + user.id.toString(),
        data: user.toJson(),
      );

      return UserModel.fromJson(response.data);
    } on DioException catch (e) {
      if (e.response?.statusCode == 400) {
        // final String errorMessage = e.response?.data["message"];

        throw const ServerException(message: INVALID_CREDENTIALS);
      } else {
        throw const ServerException(message: UNEXPECTED_ERROR);
      }
    }
  }
}
