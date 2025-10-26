import 'package:super_fitness_app/features/auth/goal_and_activity/data/models/register_request_model.dart';
import 'package:super_fitness_app/features/auth/goal_and_activity/data/models/register_response_model.dart';

abstract interface class RegisterRemoteDataSource {
  Future<RegisterResponseModel> register(
    RegisterRequestModel registerRequestModel,
  );
}
