import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/core/network/api_results.dart';
import 'package:super_fitness_app/features/details_food/data/data_source/details_food_ds.dart';
import 'package:super_fitness_app/features/details_food/data/models/mapper/details_food_mapper.dart';
import 'package:super_fitness_app/features/details_food/domain/entities/details_food_entity.dart';
import 'package:super_fitness_app/features/details_food/domain/repositories/details_food_repo.dart';

@Injectable(as: DetailsFoodRepo)
class DetailsFoodRepoImp implements DetailsFoodRepo {
  final DetailsFoodDataSource _detailsFoodDataSource;
  DetailsFoodRepoImp(this._detailsFoodDataSource);
  @override
  Future<ApiResult<DetailsFoodEntity>> detailsFoodRepo(String mealId) {
    return safeApiCall(() async {
      final responseDto = await _detailsFoodDataSource
          .detailsFoodByIdDataSource(mealId);
      final mealDto = responseDto.meals.first;
      return mealDto.toEntity();
    });
  }
}
