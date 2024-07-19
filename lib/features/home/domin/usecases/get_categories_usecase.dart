import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/category_entity.dart';
import '../repositories/home_repository.dart';

class GetCategoriesUsecase implements UseCase<List<CategoryEntity>, NoParams> {
  final HomeRepository homeRepository;

  GetCategoriesUsecase({required this.homeRepository});
  @override
  Future<Either<Failure, List<CategoryEntity>>> call(NoParams params) {
    return homeRepository.getCategoris();
  }
}
