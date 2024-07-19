import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/user.dart';
import '../repositories/auth_repository.dart';


class UpdateUsecase {
  final AuthRepository repository;

  UpdateUsecase({required this.repository});

  Future<Either<Failure, User>> call(User user) async {
    return await repository.updateUser(user);
  }
}
