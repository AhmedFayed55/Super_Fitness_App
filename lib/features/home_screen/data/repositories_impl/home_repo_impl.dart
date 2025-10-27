import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/core/network/api_results.dart';
import 'package:super_fitness_app/features/home_screen/data/data_sources/home_ds.dart';
import 'package:super_fitness_app/features/home_screen/data/mapper/to_entity_mapper.dart';
import 'package:super_fitness_app/features/home_screen/domain/entities/recommendation_for_you/meals_categories_entity.dart';
import 'package:super_fitness_app/features/home_screen/domain/entities/recommendation_to_day/muscles_random_entity.dart';
import 'package:super_fitness_app/features/home_screen/domain/entities/upcoming_workouts/get_all_muscles_entity.dart';
import 'package:super_fitness_app/features/home_screen/domain/entities/upcoming_workouts/muscles_group_id_entity.dart';
import 'package:super_fitness_app/features/home_screen/domain/repositories/home_repo.dart';

@Injectable(as: HomeRepo)
class HomeRepoImpl implements HomeRepo {
  final HomeDataSource _dataSource;
  HomeRepoImpl(this._dataSource);

  @override
  Future<ApiResult<GetAllMusclesEntity>> getAllMuscles() {
    return safeApiCall<GetAllMusclesEntity>(() async {
      final response = await _dataSource.getAllMuscles();
      return response.toEntity();
    });
  }

  @override
  Future<ApiResult<MusclesGroupIdEntity>> getMusclesGroupId(
    String muscleGroupId,
  ) {
    return safeApiCall<MusclesGroupIdEntity>(() async {
      final response = await _dataSource.getMusclesGroupId(muscleGroupId);
      return response.toEntity();
    });
  }

  @override
  Future<ApiResult<MealsCategoriesEntity>> recommendationForYou() {
    return safeApiCall<MealsCategoriesEntity>(() async {
      final response = await _dataSource.recommendationForYou();
      return response.toEntity();
    });
  }

  @override
  Future<ApiResult<MusclesRandomEntity>> recommendationToDay() {
    return safeApiCall<MusclesRandomEntity>(() async {
      final response = await _dataSource.recommendationToDay();
      return response.toEntity();
    });
  }
}
