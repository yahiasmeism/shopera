import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/user.dart';
import '../repositories/auth_repository.dart';


class RegisterUsecase {
  final AuthRepository repository;

  RegisterUsecase({required this.repository});

 Future<Either<Failure,User>> call(String userName ,String email, String password) async {
    return await repository.register(userName ,email, password);
  }
}