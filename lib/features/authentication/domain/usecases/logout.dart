import 'package:dartz/dartz.dart';
import '../repositories/auth_repository.dart';
import 'package:shopera/core/errors/failures.dart';





class LogoutUseCase {
  final AuthRepository repository;

  LogoutUseCase({required this.repository});

  Future<Either<Failure, Unit>> call() async {
    return await repository.logout();
  }
}
