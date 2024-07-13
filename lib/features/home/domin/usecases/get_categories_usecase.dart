import 'package:dartz/dartz.dart';
import 'package:shopera/core/errors/failures.dart';
import 'package:shopera/core/usecases/usecase.dart';
import 'package:shopera/features/home/domin/repositories/home_repository.dart';

class GetCategoriesUsecase implements UseCase<List<String>, NoParams> {
  final HomeRepository homeRepository;

  GetCategoriesUsecase({required this.homeRepository});
  @override
  Future<Either<Failure, List<String>>> call(NoParams params) {
    return homeRepository.getCategoris();
  }
}
