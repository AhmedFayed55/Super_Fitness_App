import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:super_fitness_app/features/auth/goal_and_activity/data/models/register_request_model.dart';
import 'package:super_fitness_app/features/auth/goal_and_activity/data/models/register_response_model.dart';

import 'network_constants.dart';

part 'api_services.g.dart';

@RestApi()
@injectable
abstract class ApiServices {
  @factoryMethod
  factory ApiServices(Dio dio) = _ApiServices;

  @POST(EndPoints.register)
  Future<RegisterResponseModel> register(
    @Body() RegisterRequestModel registerRequestModel,
  );
}
