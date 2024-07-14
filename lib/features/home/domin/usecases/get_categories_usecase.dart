import 'package:dartz/dartz.dart';
import 'package:shopera/core/errors/failures.dart';
import 'package:shopera/core/usecases/usecase.dart';
import 'package:shopera/features/home/domin/entities/category_entity.dart';
import 'package:shopera/features/home/domin/repositories/home_repository.dart';

class GetCategoriesUsecase implements UseCase<List<CategoryEntity>, NoParams> {
  final HomeRepository homeRepository;

  GetCategoriesUsecase({required this.homeRepository});
  @override
  Future<Either<Failure, List<CategoryEntity>>> call(NoParams params) {
    return homeRepository.getCategoris();
  }
}
