import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/core/network/api_results.dart';
import 'package:super_fitness_app/features/popular_training/data_sources/mapper/to_dto_mapper.dart';
import 'package:super_fitness_app/features/popular_training/data_sources/mapper/to_entity_mapper.dart';
import 'package:super_fitness_app/features/popular_training/data_sources/sources/remote/popular_training_remote_ds.dart';
import 'package:super_fitness_app/features/popular_training/domain/entities/request/get_all_exercises_request_entity.dart';
import 'package:super_fitness_app/features/popular_training/domain/entities/response/get_all_exercises_response_entity.dart';
import 'package:super_fitness_app/features/popular_training/domain/repositories/popular_training_repo.dart';

@Injectable(as: PopularTrainingRepository)
class PopularTrainingRepositoryImpl implements PopularTrainingRepository {
  final PopularTrainingRemoteDs _remoteDataSource;

  PopularTrainingRepositoryImpl(this._remoteDataSource);

  @override
  Future<ApiResult<GetAllExercisesResponseEntity>> getAllExercises(
    GetAllExercisesRequestEntity request,
  ) async {
    return await safeApiCall(() async {
      final response = await _remoteDataSource.getAllExercises(request.toDto());
      return response.toEntity();
    });
  }
}
