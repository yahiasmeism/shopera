import 'package:dartz/dartz.dart';
import 'package:shopera/features/authentication/domain/entities/user.dart';

import '../../../../core/errors/failures.dart';


abstract class AuthRepository  {

  Future<Either<Failure,User>> login( String userName, String password);
  
  Future<Either<Failure,User>> register( String userName ,String email, String password);
  Future<Either<Failure,User>> updateUser(User user);

}
