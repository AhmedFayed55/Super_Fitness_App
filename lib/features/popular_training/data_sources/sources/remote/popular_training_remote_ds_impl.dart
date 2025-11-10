import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/core/network/api_services.dart';
import 'package:super_fitness_app/features/popular_training/data_sources/models/request/get_all_exercises_request_dto.dart';
import 'package:super_fitness_app/features/popular_training/data_sources/models/response/get_all_exercises_response_dto.dart';
import 'package:super_fitness_app/features/popular_training/data_sources/sources/remote/popular_training_remote_ds.dart';

@Injectable(as: PopularTrainingRemoteDs)
class PopularTrainingRemoteDsImpl implements PopularTrainingRemoteDs {
  final ApiServices _apiService;

  PopularTrainingRemoteDsImpl({required ApiServices apiService})
    : _apiService = apiService;

  @override
  Future<GetAllExercisesResponseDto> getAllExercises(
    GetAllExercisesRequestDto request,
  ) {
    return _apiService.getAllExercises(request);
  }
}
