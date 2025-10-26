import 'package:super_fitness_app/core/network/api_results.dart';
import 'package:super_fitness_app/features/auth/goal_and_activity/data/models/register_request_model.dart';
import 'package:super_fitness_app/features/auth/goal_and_activity/domain/entities/register_response_entity.dart';

abstract interface class RegisterRepository {
  Future<ApiResult<RegisterResponseEntity>> register(
    RegisterRequestModel registerRequestModel,
  );
}
