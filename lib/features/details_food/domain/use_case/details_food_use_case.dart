import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/core/network/api_results.dart';
import 'package:super_fitness_app/features/details_food/domain/entities/details_food_entity.dart';
import 'package:super_fitness_app/features/details_food/domain/repositories/details_food_repo.dart';

@injectable
class DetailsFoodUseCase {
  final DetailsFoodRepo _detailsFoodRepo;
  DetailsFoodUseCase(this._detailsFoodRepo);
  Future<ApiResult<DetailsFoodEntity>> call(String mealId) {
    return _detailsFoodRepo.detailsFoodRepo(mealId);
  }
}
