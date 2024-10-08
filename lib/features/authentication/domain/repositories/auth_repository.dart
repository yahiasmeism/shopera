import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/user.dart';

abstract class AuthRepository {
  Future<Either<Failure, User>> login(String userName, String password);

  Future<Either<Failure, User>> register(String userName, String email, String password);
  Future<Either<Failure, User>> updateUser(User user);
  Future<Either<Failure, User>> getCurrentUser();
  Future<Unit> logout();
}
