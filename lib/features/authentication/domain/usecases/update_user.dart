import 'package:dartz/dartz.dart';
import 'package:shopera/core/errors/failures.dart';
import 'package:shopera/features/authentication/domain/entities/user.dart';
import 'package:shopera/features/authentication/domain/repositories/auth_repository.dart';


class UpdateUsecase {
  final AuthRepository repository;

  UpdateUsecase({required this.repository});

  Future<Either<Failure, User>> call(User user) async {
    return await repository.updateUser(user);
  }
}
