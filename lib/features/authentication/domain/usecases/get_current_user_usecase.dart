import 'package:dartz/dartz.dart';

import 'package:shopera/core/errors/failures.dart';
import 'package:shopera/features/authentication/domain/entities/user.dart';
import 'package:shopera/features/authentication/domain/repositories/auth_repository.dart';

import '../../../../core/usecases/usecase.dart';

class GetCurrentUserUsecase implements UseCase<User, NoParams> {
  final AuthRepository repository;

  GetCurrentUserUsecase({required this.repository});
  @override
  Future<Either<Failure, User>> call(NoParams params) {
    return repository.getCurrentUser();
  }
}
