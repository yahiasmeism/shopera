import 'package:dartz/dartz.dart';
import 'package:shopera/core/errors/failures.dart';
import 'package:shopera/features/authentication/domain/entities/user.dart';
import 'package:shopera/features/authentication/domain/repositories/auth_repository.dart';


class RegisterUsecase {
  final AuthRepository repository;

  RegisterUsecase({required this.repository});

 Future<Either<Failure,User>> call(String userName ,String email, String password) async {
    return await repository.register(userName ,email, password);
  }
}