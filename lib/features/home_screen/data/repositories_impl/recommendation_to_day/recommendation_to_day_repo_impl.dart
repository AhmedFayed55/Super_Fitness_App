import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/core/network/api_results.dart';
import 'package:super_fitness_app/features/home_screen/data/data_sources/recommendation_to_day/recommendation_to_day_remote_ds.dart';
import 'package:super_fitness_app/features/home_screen/data/mapper/to_entity_mapper.dart';
import 'package:super_fitness_app/features/home_screen/domain/entities/recommendation_to_day/muscles_random_entity.dart';
import 'package:super_fitness_app/features/home_screen/domain/repositories/recommendation_to_day/recommendation_to_day_repo.dart';

@Injectable(as: RecommendationToDayRepo)
class RecommendationToDayRepoImpl implements RecommendationToDayRepo {
  final RecommendationToDayRemoteDs recommendationToDayRemoteDs;

  RecommendationToDayRepoImpl({required this.recommendationToDayRemoteDs});

  @override
  Future<ApiResult<MusclesRandomEntity>> recommendationToDay() async {
    return await safeApiCall<MusclesRandomEntity>(() async {
      var mealsCategoriesResponse = await recommendationToDayRemoteDs
          .recommendationToDay();
      var mealsCategoriesEntity = mealsCategoriesResponse.toEntity();
      return mealsCategoriesEntity;
    });
  }
}
