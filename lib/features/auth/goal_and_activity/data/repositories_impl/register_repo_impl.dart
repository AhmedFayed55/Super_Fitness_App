import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/core/network/api_results.dart';
import 'package:super_fitness_app/features/auth/goal_and_activity/data/data_sources/remote/register_remote_ds.dart';
import 'package:super_fitness_app/features/auth/goal_and_activity/data/mapper/to_entity_mapper.dart';
import 'package:super_fitness_app/features/auth/goal_and_activity/data/models/register_request_model.dart';
import 'package:super_fitness_app/features/auth/goal_and_activity/domain/entities/register_response_entity.dart';
import 'package:super_fitness_app/features/auth/goal_and_activity/domain/repositories/register_repo.dart';

@Injectable(as: RegisterRepository)
class RegisterRepositoryImpl implements RegisterRepository {
  RegisterRemoteDataSource registerRemoteDataSource;

  RegisterRepositoryImpl({required this.registerRemoteDataSource});

  @override
  Future<ApiResult<RegisterResponseEntity>> register(
    RegisterRequestModel registerRequestModel,
  ) async {
    return await safeApiCall<RegisterResponseEntity>(() async {
      var registerResponseModel = await registerRemoteDataSource.register(
        registerRequestModel,
      );
      var registerResponseEntity = registerResponseModel.toEntity();
      return registerResponseEntity;
    });
  }
}
