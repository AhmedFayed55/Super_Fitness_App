import 'package:super_fitness_app/features/home_screen/data/models/recommendation_to_day/muscles_random_response.dart';

abstract interface class RecommendationToDayRemoteDs {
  Future<MusclesRandomResponse> recommendationToDay();
}
