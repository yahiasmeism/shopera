import 'package:dartz/dartz.dart';
import '../repositories/auth_repository.dart';
class LogoutUseCase {
  final AuthRepository repository;

  LogoutUseCase({required this.repository});

  Future<Unit> call() async {
    return await repository.logout();
  }
}
