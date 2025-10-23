import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/core/network/api_services.dart';
import 'package:super_fitness_app/features/auth/goal_and_activity/data/models/register_request_model.dart';

import 'package:super_fitness_app/features/auth/goal_and_activity/data/models/register_response_model.dart';

import 'register_remote_ds.dart';

@Injectable(as: RegisterRemoteDataSource)
class RegisterRemoteDataSourceImpl implements RegisterRemoteDataSource {
  ApiServices apiServices;

  RegisterRemoteDataSourceImpl({required this.apiServices});

  @override
  Future<RegisterResponseModel> register(
    RegisterRequestModel registerRequestModel,
  ) async {
    var registerResponseModel = await apiServices.register(
      registerRequestModel,
    );
    return registerResponseModel;
  }
}
