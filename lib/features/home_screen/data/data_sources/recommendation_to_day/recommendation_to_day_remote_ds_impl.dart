import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/core/network/api_services.dart';
import 'package:super_fitness_app/features/home_screen/data/models/recommendation_to_day/muscles_random_response.dart';

import 'recommendation_to_day_remote_ds.dart';

@Injectable(as: RecommendationToDayRemoteDs)
class RecommendationToDayRemoteDsImpl implements RecommendationToDayRemoteDs {
  ApiServices apiServices;

  RecommendationToDayRemoteDsImpl({required this.apiServices});

  @override
  Future<MusclesRandomResponse> recommendationToDay() async {
    var musclesRandomResponse = await apiServices.recommendationToDay();
    return musclesRandomResponse;
  }
}
