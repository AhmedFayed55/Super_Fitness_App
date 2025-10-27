import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/core/network/api_results.dart';
import 'package:super_fitness_app/features/home_screen/data/data_sources/recommendation_for_you/recommendation_for_you_remote_ds.dart';
import 'package:super_fitness_app/features/home_screen/data/mapper/to_entity_mapper.dart';
import 'package:super_fitness_app/features/home_screen/domain/entities/recommendation_for_you/meals_categories_entity.dart';
import 'package:super_fitness_app/features/home_screen/domain/repositories/recommendation_for_you/recommendation_for_you_repo.dart';

@Injectable(as: RecommendationForYouRepo)
class RecommendationForYouRepoImpl implements RecommendationForYouRepo {
  final RecommendationForYouRemoteDs recommendationForYouRemoteDs;

  RecommendationForYouRepoImpl({required this.recommendationForYouRemoteDs});

  @override
  Future<ApiResult<MealsCategoriesEntity>> recommendationForYou() async {
    return await safeApiCall<MealsCategoriesEntity>(() async {
      var mealsCategoriesResponse = await recommendationForYouRemoteDs
          .recommendationForYou();
      var mealsCategoriesEntity = mealsCategoriesResponse.toEntity();
      return mealsCategoriesEntity;
    });
  }
}
