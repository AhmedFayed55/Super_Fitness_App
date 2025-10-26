import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/core/network/api_results.dart';
import 'package:super_fitness_app/features/auth/goal_and_activity/data/models/register_request_model.dart';
import 'package:super_fitness_app/features/auth/goal_and_activity/domain/entities/register_response_entity.dart';
import 'package:super_fitness_app/features/auth/goal_and_activity/domain/repositories/register_repo.dart';

@injectable
class RegisterUseCase {
  RegisterRepository registerRepository;

  RegisterUseCase({required this.registerRepository});

  Future<ApiResult<RegisterResponseEntity>> register(
    RegisterRequestModel registerRequestModel,
  ) async {
    var result = await registerRepository.register(registerRequestModel);
    return result;
  }
}
